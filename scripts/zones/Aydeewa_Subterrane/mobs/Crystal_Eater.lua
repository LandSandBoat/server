-----------------------------------
-- Area: Aydeewa Subterrane
-- NM: Crystal Eater
-- To do: It is theorized that this NM spawns with different attributes (MDB, resistances etc.) based on the crystal/cluster used to feed/spawn it. More testing is needed.
-----------------------------------
local ID = zones[xi.zone.AYDEEWA_SUBTERRANE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 463)

    local npc = GetNPCByID(ID.npc.DAMPSOIL)
    if npc then
        npc:setLocalVar('tradeCooldown', GetSystemTime() + 3600) -- 60-minute cooldown
    end
end

return entity
