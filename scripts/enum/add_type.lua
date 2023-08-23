xi = xi or {}

-- addType, used in ability:getAddType(). the addType of an ability is defined in sql.
xi.addType =
{
    ADDTYPE_NORMAL      = 0,
    ADDTYPE_MERIT       = 1,
    ADDTYPE_ASTRAL_FLOW = 2,
    ADDTYPE_MAIN_ONLY   = 4,
    ADDTYPE_LEARNED     = 8,
    ADDTYPE_LIGHT_ARTS  = 16,
    ADDTYPE_DARK_ARTS   = 32,
    ADDTYPE_JUGPET      = 64,
    ADDTYPE_CHARMPET    = 128,
    ADDTYPE_AVATAR      = 256,
    ADDTYPE_AUTOMATON   = 512,
}
