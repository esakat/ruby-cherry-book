def convert_length(length, unit_form, unit_to)
  units = { 'm' => 1.0, 'ft' => 3.28, 'in' => 39.37 }
  (length / units[unit_form] * units[unit_to]).round(2)
end