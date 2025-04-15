#include <stdio.h>
#include <string.h>

int suf_pre(char* str1, char* str2) {
    int len1 = strlen(str1);
    int len2 = strlen(str2);
    int min_len = len1 < len2 ? len1 : len2;

    for (int i = min_len; i > 0; i--) {
        if (memcmp(str1, str2 + len2 - i, i) == 0) {
            return i;
        }
    }

    return 0;
}


int main() {
    printf("%d\n", suf_pre("cde", "abcde"));  // Output: 3
    printf("%d\n", suf_pre("xyz", "abcde"));  // Output: 0
    printf("%d\n", suf_pre("abc", "abcde"));  // Output: 0
    printf("%d\n", suf_pre("deghsaj", "abcde"));  // Output: 2
    printf("%d\n", suf_pre("a", "abcde"));  // Output: 0
    printf("%d\n", suf_pre("e", "abcde"));  // Output: 1
    printf("%d\n", suf_pre("abcdef", "abcde"));  // Output: 5
    printf("%d\n", suf_pre("bcdez", "abcde"));  // Output: 4
}
