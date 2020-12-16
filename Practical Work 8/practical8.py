import re

# question 1
print("-----QUESTION 1-----")
def factorial(n):
    if n == 1: 
        return n
    else:
        return n * factorial(n-1)
        

print(factorial(1))
print(factorial(2))
print(factorial(3))
print(factorial(4)) 
print("--------------------\n\n")

# question 2
print("-----QUESTION 2-----")
def word_sorter(quote):
    words = quote.split(',')
    words.sort()
    quote = words[0]
    words.pop(0)
    for w in words:
        quote = quote + "," + w 
    print(quote)
    return quote

word_sorter("without,hurra,bag,world")
print("--------------------\n\n")

# question 3
print("-----QUESTION 3-----")
def word_sorter_duplicate_remover(quote):
    words = quote.split(' ')
    words = list(dict.fromkeys(words))
    words.sort()
    quote = words[0]
    words.pop(0)
    for w in words:
        quote = quote + " " + w 
    print(quote)
    return quote

word_sorter_duplicate_remover("eggs spam bacon spam spam bacon spam spam bacon")
print("--------------------\n\n")

# question 4
print("-----QUESTION 4-----")
def word_frequency(quote):
    raw_words = quote.split(' ')
    words = []
    counters = []

    # initialize counters, filling arrays and removing duplicates 
    for i in range(len(raw_words)):
        if raw_words[i] not in words:
            words.append(raw_words[i])
            counters.append(1)
        else:
            for j in range(len(words)):
                if raw_words[i] == words[j]:
                    counters[j] = counters[j] + 1 

    words_saved = words.copy()    
    words.sort()

    new_indexes = []

    # see new positions after sorted words 
    for w1 in words:
        for w2 in words_saved:
            if w1 == w2:
                new_indexes.append(words_saved.index(w1))

    # update counters position
    new_counters = []

    for i in range(len(new_indexes)):
        new_counters.append(counters[new_indexes[i]])

    # print
    for i in range(len(words)):
        print (words[i] + ':' + str(new_counters[i]))

word_frequency("eggs spam bacon spam spam bacon spam spam bacon")
print("--------------------\n\n")

# question 5
print("-----QUESTION 5-----")
def mail_regex(mail):
    pattern = "(?<=@).+?.+?(?=\.)"
    result = re.findall(pattern, mail)
    print(result[0])
    return result

mail_regex("jorallo@dsic.upv.es")
mail_regex("up201604503@fe.up.pt")
mail_regex("jaojao.uahaui@hhh.pol.com")
print("--------------------\n\n")