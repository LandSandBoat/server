xi = xi or {}

-- see `enum ENTITYUPDATE` in src\map\packets\basic.h
---@enum entityUpdate
xi.entityUpdate =
{
    ENTITY_SPAWN   = 0,
    ENTITY_SHOW    = 1,
    ENTITY_UPDATE  = 2,
    ENTITY_HIDE    = 3,
    ENTITY_DESPAWN = 4,
}
