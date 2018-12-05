class ExampleMailer < ApplicationMailer
    default from: "practiceproductmanagement@gmail.com"
    
    def sample_email(user)
        @user = user
        mail(to: @user.email, subject: 'Sample Email')
    end
end
