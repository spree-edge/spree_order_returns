Deface::Override.new(
  virtual_path: 'spree/admin/products/_form',
  name: 'add_returnable_field',
  insert_after: "[data-hook='admin_product_form_promotionable']",
  text: '<% if Flipper.enabled?(:order_returns, current_store.try(:id)) %>
          <%= f.fields :product_return_data, model: f.object.product_return_data do |field| %>
            <div class="form-group" data-hook="admin_product_form_returnable">
              <%= field.check_box :returnable, checked: @product.product_return_data.dig("returnable") == "1"%>
              <%= field.label :returnable, Spree.t(:returnable) %>
            </div>
            <div class="form-group <%= @product.product_return_data.dig("returnable") == "0" ? "d-none" : "d-block" %>" id="returnable-days">
              <%= field.label :returnable_days, Spree.t(:returnable_days) %>
              <%= field.number_field :returnable_days, value: @product.product_return_data.dig("returnable_days"), min: 0, id:"returnable-days-field", class:"form-control"%>
            </div>
          <% end %>
        <% end %>'
)

Deface::Override.new(
  virtual_path:'spree/admin/products/_form',
  name:'adding_js',
  insert_bottom:"[data-hook='admin_product_form_fields']",
  text: "<% if Flipper.enabled?(:order_returns, current_store.try(:id)) %>
          <script>
              document.addEventListener('change', function() {
              const returnableCheckbox = document.getElementById('product_product_return_data_returnable');
              const returnableDaysField= document.getElementById('returnable-days-field');
              const returnableDaysFieldContainer= document.getElementById('returnable-days');
              // Function to make the AJAX request and update the input field visibility
              function updateInputFieldVisibility() {
                if (returnableCheckbox.checked) {
                  returnableDaysFieldContainer.classList.remove('d-none')
                  returnableDaysFieldContainer.classList.add('d-block')
                  returnableDaysField.disabled = false;
                } else {
                  returnableDaysFieldContainer.classList.remove('d-block')
                  returnableDaysFieldContainer.classList.add('d-none')
                  returnableDaysField.disabled = true;
                }
              }
              updateInputFieldVisibility();
              returnableCheckbox.addEventListener('change', updateInputFieldVisibility);
            });
          </script>
        <% end %>"
  )
