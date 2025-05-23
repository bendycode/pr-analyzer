require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  let(:admin) { create(:admin, email: 'admin@example.com', password: 'password123') }

  before do
    sign_in admin
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit
      expect(response).to be_successful
    end

    it "assigns the current admin" do
      get :edit
      expect(assigns(:admin)).to eq(admin)
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      context "when updating email only" do
        let(:new_attributes) { { email: 'newemail@example.com' } }

        it "updates the admin's email" do
          patch :update, params: { admin: new_attributes }
          admin.reload
          expect(admin.email).to eq('newemail@example.com')
        end

        it "redirects to the edit page" do
          patch :update, params: { admin: new_attributes }
          expect(response).to redirect_to(edit_account_path)
        end

        it "shows a success notice" do
          patch :update, params: { admin: new_attributes }
          expect(flash[:notice]).to eq('Account was successfully updated.')
        end
      end

      context "when updating password" do
        let(:new_attributes) do
          {
            password: 'newpassword123',
            password_confirmation: 'newpassword123',
            current_password: 'password123'
          }
        end

        it "updates the admin's password" do
          patch :update, params: { admin: new_attributes }
          admin.reload
          expect(admin.valid_password?('newpassword123')).to be true
        end

        it "redirects to the edit page" do
          patch :update, params: { admin: new_attributes }
          expect(response).to redirect_to(edit_account_path)
        end
      end
    end

    context "with invalid params" do
      context "when current password is wrong" do
        let(:invalid_attributes) do
          {
            password: 'newpassword123',
            password_confirmation: 'newpassword123',
            current_password: 'wrongpassword'
          }
        end

        it "does not update the admin" do
          patch :update, params: { admin: invalid_attributes }
          admin.reload
          expect(admin.valid_password?('newpassword123')).to be false
        end

        it "renders the edit template" do
          patch :update, params: { admin: invalid_attributes }
          expect(response).to render_template(:edit)
        end
      end

      context "when password confirmation doesn't match" do
        let(:invalid_attributes) do
          {
            password: 'newpassword123',
            password_confirmation: 'differentpassword',
            current_password: 'password123'
          }
        end

        it "does not update the admin" do
          patch :update, params: { admin: invalid_attributes }
          admin.reload
          expect(admin.valid_password?('newpassword123')).to be false
        end

        it "renders the edit template" do
          patch :update, params: { admin: invalid_attributes }
          expect(response).to render_template(:edit)
        end
      end

      context "when email is invalid" do
        let(:invalid_attributes) { { email: 'invalid-email' } }

        it "does not update the admin" do
          patch :update, params: { admin: invalid_attributes }
          admin.reload
          expect(admin.email).to eq('admin@example.com')
        end

        it "renders the edit template" do
          patch :update, params: { admin: invalid_attributes }
          expect(response).to render_template(:edit)
        end
      end
    end
  end

  describe "authorization" do
    it "ensures admin can only edit their own account" do
      get :edit
      expect(assigns(:admin)).to eq(admin)
    end
  end
end