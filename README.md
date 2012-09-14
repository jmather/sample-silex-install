# Sample Silex Install

This is a sample appliction I set up to show how easy it is to get started with Silex,
while also not compormising your ability to organize your code in a sane manor.

This is really easy to get started:

    curl -s http://getcomposer.org/installer | php
    ./composer.phar install

I have also included a sample Capistrano deployment configuration which includes
dependancy on tests passing and composer commands. Just modify the included 
`config/deploy.rb` to suit your needs.
