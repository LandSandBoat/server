-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Nightmare Uragnite
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_dreamland'),
    require('scripts/mixins/families/uragnite'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
    mob:setLocalVar('dynamis_currency', 1455)

    xi.mix.uragnite.config(mob,
    {
        inShellSkillList = 2112,
        noShellSkillList = 2113,
        inShellRegen     =  100,
    })
end

return entity
