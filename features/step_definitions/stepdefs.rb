require "selenium-webdriver"
require 'webdrivers'

def rand_percentage_rate()
    rand_obj = Random.new
    rand_obj.rand(5.0..12.0)
end

def calc_payment(sum, n, i)
  sum * i *(1 + i)**n / ((1 + i)**n - 1)
end

Given("Opened page") do
  @driver = Selenium::WebDriver.for :chrome
  @driver.get('https://calcus.ru/kalkulyator-ipoteki')
  @driver.manage.timeouts.implicit_wait = 10

  search_header = @driver.find_element(:xpath, "//h1")
  expect(search_header.text).to eq("Ипотечный калькулятор")

  search_link1 = @driver.find_element(:xpath, "//form/div/div/a[text()=\"По стоимости недвижимости\"]")
  expect(search_link1).not_to eq(nil)

  search_link2 = @driver.find_element(:xpath, "//form/div/div/a[text()=\"По сумме кредита\"]")
  expect(search_link2).not_to eq(nil)

  search_element1 = @driver.find_element(:xpath, "//form/div/div[text()=\"Стоимость недвижимости\"]")
  expect(search_element1).not_to eq(nil)

  search_element2 = @driver.find_element(:xpath, "//form/div/div[text()=\"Первоначальный взнос\"]")
  expect(search_element2).not_to eq(nil)

  search_element3 = @driver.find_element(:xpath, "//form/div/div[text()=\"Сумма кредита\"]")
  expect(search_element3).not_to eq(nil)

  search_element4 = @driver.find_element(:xpath, "//form/div/div[text()=\"Срок кредита\"]")
  expect(search_element4).not_to eq(nil)

  search_element5 = @driver.find_element(:xpath, "//form/div/div[contains(text(), \"Процентная ставка\")]")
  expect(search_element5).not_to eq(nil)

  search_element6 = @driver.find_element(:xpath, "//form/div/div[contains(text(), \"Тип ежемесячных платежей\")]")
  expect(search_element6).not_to eq(nil)

end

When("Input parameters") do
  search_cost = @driver.find_element(:xpath, "//input[@name=\"cost\"]")
  search_cost.send_keys("12000000")

  search_start_sum_type = @driver.find_element(:xpath, "//select[@name=\"start_sum_type\"]")
  search_start_sum_type.send_keys("\ue015")

  search_start_sum = @driver.find_element(:xpath, "//input[@name=\"start_sum\"]")
  search_start_sum.send_keys("20")

  search_calculated_start_sum = @driver.find_element(:xpath, "//form/div/div[text()=\"Первоначальный взнос\"]/following-sibling::div/div[3]")
  expect(search_calculated_start_sum.text).to eq("(2 400 000 руб.)")

  search_element = @driver.find_element(:xpath, "//form/div/div[text()=\"Сумма кредита\"]/following-sibling::div/span[1]")
  expect(search_element).not_to eq("9 600 000")

  search_period_field = @driver.find_element(:xpath, "//input[@name=\"period\"]")
  search_period_field.send_keys("20")

  search_percent_field = @driver.find_element(:xpath, "//input[@name=\"percent\"]")
  @percent = rand_percentage_rate().round(2)
  search_percent_field.send_keys(@percent.to_s)

  search_payment_type1 = @driver.find_element(:xpath, "//input[@id=\"payment-type-1\"]")

  search_payment_type2 = @driver.find_element(:xpath, "//input[@id=\"payment-type-2\"]")

  search_button_calculate = @driver.find_element(:xpath, "//input[@value=\"Рассчитать\"]")
  search_button_calculate.click()

end

Then("Check payment") do
  search_payment = @driver.find_element(:xpath, "//div[contains(text(), \"Ежемесячный платеж\")]/following-sibling::div/div")
  expect(search_payment.text.delete(' ')).to eq(calc_payment(12000000.0, 20, @percent / 100.0).round(2).to_s)
end
