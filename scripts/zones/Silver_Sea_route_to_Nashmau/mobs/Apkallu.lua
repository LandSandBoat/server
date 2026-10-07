-----------------------------------
-- Area: Silver Sea route to Nashmau
--  Mob: Apkallu
-- !pos 9.036 -7.163 12.610 58
-----------------------------------
mixins = { require('scripts/mixins/ferry_apkallu') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    -- Board opposite Almighty Apkallu, then roam inside the existing deck region.
    mob:setPos(9.036, -7.163, 12.610, 128)
end

return entity
