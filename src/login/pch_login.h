/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Team

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#pragma once

// Login Server Precompiled Headers
// This builds upon the common PCH and adds login-specific headers

// Include the base common PCH first
#include "../common/pch_common.h"

// Login-specific headers based on usage analysis
// These are the most frequently used headers in the login server

// Login server has fewer source files, so focus on the most common ones
// Based on xi_connect analysis (33 files):

// logging.h - 36.4% usage (12/33 files) - Already in common PCH via common/logging.h
// tracy.h - 21.2% usage (7/33 files) - Profiling (conditional)
#ifdef ENABLE_TRACY
#include "tracy.h"
#endif

// Login-specific application headers
#include "connect_application.h"
#include "connect_engine.h"

// Session management (login-specific)
#include "auth_session.h"
#include "data_session.h"
#include "handler_session.h"
#include "view_session.h"

// Login helpers
#include "login_helpers.h"