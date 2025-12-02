-----------------------------------
-- Area: Sacrificial Chamber
--  Mob: Vermilion-eared Noberry
-- BCNM: Jungle Boogymen
-----------------------------------
mixins =
{
    require('scripts/mixins/families/tonberry'),
    require('scripts/mixins/job_special'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 2, 'Tonberrys_Elemental')
    mob:setMobMod(xi.mobMod.ASTRAL_PET_OFFSET, 3)
end

entity.onMobDeath = function(mob, player, optParams)
    local elementalId = mob:getID() + 2
    if GetMobByID(elementalId):isSpawned() then
        DespawnMob(elementalId)
    end
end

return entity
