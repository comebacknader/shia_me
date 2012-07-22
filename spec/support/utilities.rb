
def full_title(page_title)
  base_title = "shiaME"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def sign_in(admin)
  visit login_path
  fill_in "Email",    with: admin.email
  fill_in "Password", with: admin.password
  click_button "Log In"
  # Sign In when not using Capybara as well. 
  cookies[:remember_token] = admin.remember_token
end