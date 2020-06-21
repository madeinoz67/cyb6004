#!/usr/bin/env bats

@test "tests dependency - curl is installed" {
    run which curl
    [ "$status" -eq 0 ]
    [[ "$output" =~ "curl" ]]
}

@test "tests dependency - jq is installed" {
    run which jq
    [ "$status" -eq 0 ]
    [[ "$output" =~ "jq" ]]
}

@test "invoke script with no parameters" {
    run ${BATS_TEST_DIRNAME}/../vtfc.sh
    [ "$status" -eq 2 ]
    [[ "$output" =~ "Usage:" ]]
}

@test "invoke script with no filename" {
    run ${BATS_TEST_DIRNAME}/../vtfc.sh -m
    [ "$status" -eq 2 ]
    [[ "$output" =~ "Usage:" ]]
}

@test "invoke script with filename only" {
    run ${BATS_TEST_DIRNAME}/../vtfc.sh ${BATS_TEST_DIRNAME}/testfiles/eicar.com
    [ "$status" -eq 2 ]
    [[ "$output" =~ "Usage:" ]]
}

@test "invoke add apikey with no key" {
    run ${BATS_TEST_DIRNAME}/../vtfc.sh -a
    [ "$status" -eq 2 ]
    [[ "$output" =~ "Usage:" ]]
}

# test Disabled as causes problems with actual tests to API due to invalid Dummy API key - need to find solution
#@test "set API Key" {
#    run ${BATS_TEST_DIRNAME}/../vtfc.sh -a 1234567890
#    
#    # file to check exist
#    file=~/.vtfc
#    # check it contains VT_APIKEY=1234567890
#    status1=$(grep 'VT_APIKEY' $file )

#    [ -f "$file" ]
#    [ "$status" -eq 0 ]
#    [ "$status1" = "VT_APIKEY=1234567890" ]
#}

@test "md5 search of eicar.com testfile" {
    run ${BATS_TEST_DIRNAME}/../vtfc.sh -m ${BATS_TEST_DIRNAME}/testfiles/eicar.com
    [ "$status" -eq 1 ]
    [[ "$output" =~ "This file is likely malicious" ]]
}

@test "md5 search of eicar.com testfile - verbose result" {
    run ${BATS_TEST_DIRNAME}/../vtfc.sh -v -m ${BATS_TEST_DIRNAME}/testfiles/eicar.com
    [ "$status" -eq 1 ]
    [[ "$output" =~ "https://www.virustotal.com/gui/search/44d88612fea8a8f36de82e1278abb02f" ]]
}

@test "md5 search of non-malicious file" {
    run ${BATS_TEST_DIRNAME}/../vtfc.sh -m ${BATS_TEST_DIRNAME}/testfiles/normal.txt
    [ "$status" -eq 0 ]
    [[ "$output" =~ "This file is unlikely to be malicious:" ]]
}

@test "sha1 search of eicar.com testfile" {
    run ${BATS_TEST_DIRNAME}/../vtfc.sh -s ${BATS_TEST_DIRNAME}/testfiles/eicar.com
    [ "$status" -eq 1 ]
    [[ "$output" =~ "This file is likely malicious" ]]
}

@test "sha1 search of eicar.com testfile - verbose result" {
    run ${BATS_TEST_DIRNAME}/../vtfc.sh -v -s ${BATS_TEST_DIRNAME}/testfiles/eicar.com
    #echo $output
    [ "$status" -eq 1 ]
    [[ "$output" =~ "https://www.virustotal.com/gui/search/3395856ce81f2b7382dee72602f798b642f14140" ]]
}

@test "sha1 search of non-malicious file" {
    run ${BATS_TEST_DIRNAME}/../vtfc.sh -s ${BATS_TEST_DIRNAME}/testfiles/normal.txt
    [ "$status" -eq 0 ]
    [[ "$output" =~ "This file is unlikely to be malicious:" ]]
}