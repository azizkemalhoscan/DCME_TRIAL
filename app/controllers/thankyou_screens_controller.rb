class ThankyouScreensController < ApplicationController
  def show
  end

  def new
    @thankyou_screen = ThankyouScreen.new
  end

  def create
    @survey = Survey.find(params[:survey_id])
    @thankyou_screen = ThankyouScreen.create(thankyou_screen_params)
    @thankyou_screen.survey = @survey
    @thankyou_screen.save

    begin
      RestClient.put(
    "https://api.typeform.com/forms/#{@survey.typeform_id}", {
      title: @thankyou_screen.survey.name,
      than: [
        {
          title: @thankyou_screen.title,
          properties: {
            description: 'Thank You!',
            show_button: true,
            share_icons: false
          }
        }
      ]
    }.to_json, Authorization: "bearer #{ENV['TYPEFORM_API_TOKEN']}")
    rescue Exception => e
      raise
    end
    redirect_to survey_path(@survey)

    # Continue crete controller. Take a look at json.
  end

  def edit
  end
  # Reconsider this part
  # def update
  #   @thankyou_screen = ThankyouScreen.find(params[:id])

  #   if @thankyou_screen.update(thankyou_screen_params)
  #     # update_form_question

  #     redirect_to survey_path(@thankyou_screen.survey)
  #   else
  #     render(:edit)
  #   end

  def destroy
  end

  private

  def thankyou_screen_params
    params.require(:thankyou_screen).permit(:title)
  end
end
