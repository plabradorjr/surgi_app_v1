require './config/environment'



use Rack::MethodOverride

use UsersController
use NotesController
run ApplicationController