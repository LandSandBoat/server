-----------------------------------
-- TESTS SETTINGS
-----------------------------------
-- All settings are attached to the `xi.settings` object. This is published globally, and be accessed from C++ and any script.
--
-- This file is concerned mainly with test behavior.
-----------------------------------

xi = xi or {}
xi.settings = xi.settings or {}

xi.settings.test =
{
    -- [22:32:06][info][    CClass::func:120] Log message
    PATTERN = '[%T][%^%-4!l%$][%*] %v',
}
