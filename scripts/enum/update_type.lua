xi = xi or {}

-- see `enum UPDATETYPE` in src\map\entities\baseentity.h
xi.updateType =
{
    UPDATE_NONE     = 0x00,
    UPDATE_POS      = 0x01,
    UPDATE_STATUS   = 0x02,
    UPDATE_HP       = 0x04,
    UPDATE_COMBAT   = 0x07,
    UPDATE_NAME     = 0x08,
    UPDATE_ALL_MOB  = 0x0F,
    UPDATE_LOOK     = 0x10,
    UPDATE_ALL_CHAR = 0x1F,
    UPDATE_DESPAWN  = 0x20,
}
