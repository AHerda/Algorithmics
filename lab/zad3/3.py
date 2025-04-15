def suf_pref(str1, str2):
    for i in range(min(len(str1), len(str2)) + 1)[1:][::-1]:
        if str1[:i] == str2[-i:]:
            return i
    return 0

# Test cases
print(suf_pref("cde", "abcde"))  # Output: 3

print(suf_pref("xyz", "abcde"))  # Output: 0

print(suf_pref("abc", "abcde"))  # Output: 0

print(suf_pref("deghsaj", "abcde"))  # Output: 2

print(suf_pref("a", "abcde"))  # Output: 0

print(suf_pref("e", "abcde"))  # Output: 1

print(suf_pref("abcdef", "abcde"))  # Output: 5

print(suf_pref("bcdez", "abcde"))  # Output: 4
