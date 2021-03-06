def cls
  system('cls') || system('clear')
end

def get_letters
  word = ARGV[0]

  if word == nil || word.to_s == ''
    abort 'Для игры введите загаданное слово в качестве аргумента при ' \
      'запуске программы'
  end

  secret_word = word.split('')

  while secret_word.index('ё') != nil do
    secret_word[secret_word.index('ё')] = 'е'
  end

  while secret_word.index('й') != nil
    secret_word[secret_word.index('й')] = 'и'
  end

  secret_word
end

def get_user_input
  letter = ''

  while letter == ''
    letter = STDIN.gets.encode('UTF-8').chomp
  end

  if letter == 'ё'
    letter = 'е'
  elsif letter == 'й'
    letter = 'и'
  end

  letter
end

def check_result(user_input, letters, good_letters, bad_letters)
  if good_letters.include?(user_input) || bad_letters.include?(user_input)
    return 0
  end

  if letters.include? user_input
    good_letters << user_input
    if good_letters.uniq.sort == letters.uniq.sort
      1
    else
      0
    end
  else
    bad_letters << user_input
      -1
  end
end

def get_word_for_print(letters, good_letters)
  result = ''

  for item in letters do
    if good_letters.include?(item)
      result += item + ' '
    else
      result += '__ '
    end
  end

  result
end

def print_status(letters, good_letters, bad_letters, errors)
  puts "\nСлово: #{get_word_for_print(letters, good_letters)}"
  puts "Ошибки (#{errors}): #{bad_letters.join(', ')}"

  if errors >= 7
    puts 'Вы проиграли :('
  else
    if good_letters.uniq.sort == letters.uniq.sort
      puts "Поздравляем, вы выиграли!\n\n"
    else
      puts 'У вас осталось попыток: ' + (7 - errors).to_s
    end
  end
end
