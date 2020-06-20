#!/usr/bin/env bats

#source "${BATS_TEST_DIRNAME}/../vtfc.sh" >/dev/null 2>/dev/null

@test "invoke script with no parameters" {
    run ${BATS_TEST_DIRNAME}/../vtfc.sh
    [ "$status" -eq 2 ]
    [ "${lines[0]}" = "Usage:" ]
}

@test "invoke script with no filename" {
    run ${BATS_TEST_DIRNAME}/../vtfc.sh -m
    [ "$status" -eq 2 ]
    [ "${lines[0]}" = "Usage:" ]
}

@test "invoke script with filename only" {
    run ${BATS_TEST_DIRNAME}/../vtfc.sh ${BATS_TEST_DIRNAME}/testfiles/eicar.com
    [ "$status" -eq 2 ]
    [ "${lines[0]}" = "Usage:" ]
}

@test "invoke add apikey with no key" {
    run ${BATS_TEST_DIRNAME}/../vtfc.sh -a
    [ "$status" -eq 2 ]
    [ "${lines[0]}" = "Usage:" ]
}

@test "md5 search of eicar.com testfile" {
    run ${BATS_TEST_DIRNAME}/../vtfc.sh -m ${BATS_TEST_DIRNAME}/testfiles/eicar.com
    [ "$status" -eq 1 ]
    #[ "${lines[0]}" = "This file is likely malicious" ]
}

@test "md5 search of non-malicious file" {
    run ${BATS_TEST_DIRNAME}/../vtfc.sh -m ${BATS_TEST_DIRNAME}/testfiles/normal.txt
    [ "$status" -eq 0 ]
    #[ "$output" = "\n\033[32m This file is unlikely to be malicious: testfiles/normal.txt \033[m\n" ]
}

@test "sha1 search of eicar.com testfile" {
    run ${BATS_TEST_DIRNAME}/../vtfc.sh -s ${BATS_TEST_DIRNAME}/testfiles/eicar.com
    [ "$status" -eq 1 ]
    #[ "${lines[0]}" = "This file is likely malicious" ]
}

@test "sha1 search of non-malicious file" {
    run ${BATS_TEST_DIRNAME}/../vtfc.sh -s ${BATS_TEST_DIRNAME}/testfiles/normal.txt
    [ "$status" -eq 0 ]
    [ "$output" = "\n\033[32m This file is unlikely to be malicious: testfiles/normal.txt \033[m\n" ]
}