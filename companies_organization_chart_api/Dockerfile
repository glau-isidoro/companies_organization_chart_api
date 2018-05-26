FROM ruby:2.5
RUN mkdir /companies_organization_chart_api
WORKDIR /companies_organization_chart_api
ADD Gemfile /companies_organization_chart_api/Gemfile
ADD Gemfile.lock /companies_organization_chart_api/Gemfile.lock
RUN bundle install
ADD . /companies_organization_chart_api
