import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"
import StimulusReflex from 'stimulus_reflex'
// import consumer from '../channels/consumer'

const application = Application.start()
const context_components = require.context("./", true, /.js$/)
application.load(
  definitionsFromContext(context_components)
)

// StimulusReflex.initialize(application, { consumer, debug: true })
