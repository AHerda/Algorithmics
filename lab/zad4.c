#include <stdio.h>
#include <string.h>

int pattern(char* str, char* pattern) {
    int len_str = strlen(str);
    int len_pattern = strlen(pattern);

    if (!len_str || !len_pattern || len_pattern > len_str) {
        return -1;
    }

    for (int i = 0; i < len_str - len_pattern + 1; i++) {
        if (!memcmp(pattern, str + i, len_pattern)) {
            return i;
        }
    }

    return -1;
}

int main() {
    char str[] = "Hello, World!";
    char pattern1[] = "World";
    char pattern2[] = "Hello";
    char pattern3[] = "World!";
    char pattern4[] = "o, Wo";
    char pattern5[] = "Nothing";
    char pattern6[] = "Hello, World!dajhsjkda";

    printf("Pattern found at index: %d\n", pattern(str, pattern1)); // Output: 7
    printf("Pattern found at index: %d\n", pattern(str, pattern2)); // Output: 0
    printf("Pattern found at index: %d\n", pattern(str, pattern3)); // Output: 7
    printf("Pattern found at index: %d\n", pattern(str, pattern4)); // Output: 4
    printf("Pattern found at index: %d\n", pattern(str, pattern5)); // Output: -1
    printf("Pattern found at index: %d\n", pattern(str, "")); // Output: -1
    printf("Pattern found at index: %d\n", pattern("", pattern1)); // Output: -1
    printf("Pattern found at index: %d\n", pattern("", "")); // Output: -1
    printf("Pattern found at index: %d\n", pattern(str, pattern6)); // Output: -1

    return 0;
}
