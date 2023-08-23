-----------------------------------
-- Area: Valkurm Dunes
--  Mob: Beach Monk
-- Spawned During Pirates Chart Quest
-----------------------------------
local ID = require("scripts/zones/Valkurm_Dunes/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)
    mob:setMobMod(xi.mobMod.GIL_MAX, -1)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 60)
    mob:setLocalVar("spawner", 0)
end

entity.onMobFight = function(mob, target)
    mob:setLocalVar("spawner", target:getID())
    local twohour = mob:getLocalVar("twohour")

    if mob:getHPP() < 50 and twohour == 0 and not mob:hasStatusEffect(xi.effect.MEDICINE) then -- Mithra Snare prevents 2hr usage
        mob:useMobAbility(690)
        mob:setLocalVar("twohour", 1)
    end

    if mob:getLocalVar("taruSnare") == 1 then -- Tarutaru Snare lowers damage to 1 or 2, since we can't force that this is the best we can do
        mob:setDamage(0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local crab = GetMobByID(ID.mob.HEIKE_CRAB)
    local houu = GetMobByID(ID.mob.HOUU_THE_SHOALWADER)
    local barnacle = GetNPCByID(ID.npc.BARNACLED_BOX)

    if not crab:isAlive() and not houu:isAlive() then
        barnacle:setLocalVar("leaderID", player:getLeaderID())
        barnacle:teleport(mob:getPos(), mob:getRotPos())
        barnacle:setStatus(xi.status.NORMAL)
        barnacle:setLocalVar("open", 0)
    end

    mob:setLocalVar("twohour", 0)
end

return entity
