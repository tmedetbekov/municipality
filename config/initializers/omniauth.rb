Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '6EHC769CscW52wuhQyfXA', 'B3tkgnsuKwqLNgQlDb5CXgBpMMQzysuhFz3S2EhyQY'
  provider :facebook, '161411507241928', '9c4171da5a6179f6331960c31d92e502'
end
