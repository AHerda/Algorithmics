#include <stdio.h>
#include <string.h>

int is_prefix(char *str, char *prefix) {
    while (*str && *prefix && *str == *prefix) {
        str++;
        prefix++;
    }
    return *prefix == '\0';
}

int is_suffix(char *str, char *suffix) {
    size_t len_str = strlen(str);
    size_t len_suffix = strlen(suffix);
    if (len_suffix > len_str) {
        return 0;
    }
    return strcmp(str + len_str - len_suffix, suffix) == 0;
}

int main() {
    char string[] = "Hello, World!";
    char prefix[] = "Hello";
    char suffix[] = "World!";
    char not_anything[] = "Nothing";

    if (is_prefix(string, not_anything) || is_suffix(string, not_anything)) {
        printf("The string starts or ends with the not_anything.\n");
    } else {
        printf("The string does not start or end with the not_anything.\n");
    }

    if (is_prefix(string, prefix)) {
        printf("The string starts with the prefix.\n");
    } else {
        printf("The string does not start with the prefix.\n");
    }

    if (is_suffix(string, suffix)) {
        printf("The string ends with the suffix.\n");
    } else {
        printf("The string does not end with the suffix.\n");
    }

    return 0;
}
