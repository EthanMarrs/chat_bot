import { Application } from "@hotwired/stimulus"
import ResetFormController from "./form_controller"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

application.register("form", ResetFormController)

export { application }
