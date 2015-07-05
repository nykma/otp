# One-time Password Generator

A simple command line tool to generate TOTP([RFC 6238](https://tools.ietf.org/html/rfc6238), aka [Google Authenticator](https://en.wikipedia.org/wiki/Google_Authenticator)) based on (mdp/rotp)[https://github.com/mdp/rotp].

## Prepare

First, we should install dependencies, as always.

```bash
bundle install --without development
```

Then, create a `.otp.yml` in your home folder (i.e. `vim ~/.otp.yml`) like below:

```yaml
otp:
  google: YOUR_GOOGLE_AUTHENTICATOR_TOKEN_HERE
  github: YOUR_GITHUB_AUTHENTICATOR_TOKEN_HERE
```

**IMPORTANT!! Remember to set the file permissions to prevent other user from getting your secret token!**

```bash
chmod 600 ~/.otp.yml
```

If you wish, create a symlink of `main.rb`.

```bash
ln -s <THIS_REPO_DIR>/main.rb /usr/local/bin/otp
```

## Usage

```
otp [-bc] SITE_NAME

SITE_NAME     : Secret key identifier specified in .otp.yml . For the example above: google, github.
--base32 (-b) : Create a random Base32 string. No SITE_NAME needed.
--config (-c) : Specify a .otp.yml file. Default is ~/.otp.yml
```


## To-Do List

- [ ] Add HOTP([RFC 4226](https://tools.ietf.org/html/rfc4226)) support.
- [ ] Package it to [homebrew](http://brew.sh).

Issues and pull requests are always welcome.
