# define 'RandomData' as a module, because it doesn't have any dependency or inheritance requirement
# module will help us to keep 'common function' organized and reusable during whole program
# 'class' can instantiate and inherit from 'modules', but 'modules' can't do that from other module. 'modules' use 'mixins' to add function for multiple classes
module RandomData
    
    # define 'random_paragraph'
    def self.random_paragraph
        sentences = []
        rand(4..6).times do
            # use 'random_sentence' to create random sentence
            sentences << random_sentence
        
        end
        
        sentences.join("")
    
    end
    
    # define 'random_sentence'
    def self.random_sentence
        strings = []
        rand(3..8).times do
            # use 'random_word' to create random words
            strings << random_word
        end
        
        sentence = strings.join("")
        sentence.capitalize << "."
    end
    
    # define 'random_word'
    def self.random_word
          # set 'letters' to an array of the letters a~z by using '.to-a'
        letters = ('a'..'z').to_a
        # called 'shuffle!' for shuffle element in place
        # if use 'shuffle' without '!', it will just return an array but won't shuffle in place
        letters.shuffle!
        # use '[0,rand(3.8)].join' to join the zeroth~nth item into 'letters'
        # 'rand(3..8)' will return a random number between 3 to 8 
        letters[0,rand(3..8)].join
    end
end