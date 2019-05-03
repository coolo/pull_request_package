FROM opensuse/leap:15.1

RUN zypper ar https://download.opensuse.org/repositories/devel:/languages:/ruby:/extensions/openSUSE_Leap_15.1/ dlre
RUN zypper --gpg-auto-import-keys refresh
RUN zypper in -y -C 'rubygem(octokit)' 'rubygem(nokogiri) == 1.10.3' 'rubygem(ruby:2.5.0:activemodel:5.2)' 'rubygem(bundler)' osc

RUN useradd -m puller

COPY . /code
RUN chown -R puller /code
RUN ln -s /config/config.yml /code/config/
RUN ln -s /config/.oscrc /home/puller/

WORKDIR /code

USER puller

CMD ruby runner.rb
