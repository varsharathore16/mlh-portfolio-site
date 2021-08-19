#! /usr/bin/env bash

assert ()                 # exit if string not found in text
{
  text=$1
  string=$2

  if [[ $text == *"$string"* ]];
  then
    echo "'$string': passed"
  else
    echo "'$string' not found in text:"
    echo "$text"
    exit 99
  fi
}

username="$RANDOM"
password="$RANDOM"
wrongpassword="wrongpw"

homepage () { curl -s http://varsha-mlh-portfolio.duckdns.org/; }
register () { curl -s -d "username=$1&password=$2" -X POST http://varsha-mlh-portfolio.duckdns.org/register; }
login () { curl -s -d "username=$1&password=$2" -X POST http://varsha-mlh-portfolio.duckdns.org/login; }

assert "$(homepage)" "Wei He"
assert "$(register "" "$password")" "Username is required."
assert "$(register "$username" "")" "Password is required."
assert "$(register "$username" "$password")" "User ${username} created successfully"
assert "$(register "$username" "$password")" "User ${username} is already registered."
assert "$(login "" "$password")" "Incorrect username."
assert "$(login "$username" "")" "Incorrect password."
assert "$(login "$username" "$wrongpassword")" "Incorrect password."
assert "$(login "$username" "$password")" "Login Successful"
