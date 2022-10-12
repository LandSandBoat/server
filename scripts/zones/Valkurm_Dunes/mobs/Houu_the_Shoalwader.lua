-----------------------------------
-- Area: Valkurm Dunes
--  Mob: Heike Crab
-- Spawned During Pirates Chart Quest
-----------------------------------
local ID = require("scripts/zones/Valkurm_Dunes/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)
    mob:setMobMod(xi.mobMod.GIL_MAX, -1)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 8)
    mob:setLocalVar("spawner", 0)
    local qm = GetNPCByID(ID.npc.PIRATE_CHART_QM)
    qm:setLocalVar("lostinterest", 0)
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

entity.onMobDespawn = function(mob)
    local spawner = GetPlayerByID(mob:getLocalVar("spawner"))
    local qm = GetNPCByID(ID.npc.PIRATE_CHART_QM)

    local shimmering = GetNPCByID(ID.npc.SHIMMERING_POINT)
    if qm:getLocalVar("lostinterest") == 0 and spawner:getHPP() == 0 then
        qm:setLocalVar("lostinterest", 1)
        qm:showText(qm, ID.text.TOO_MUCH_TIME_PASSED)
    end

    shimmering:setStatus(xi.status.DISAPPEAR)

    local party = spawner:getParty()
    for _, member in pairs(party) do
        member:ChangeMusic(0, 0)
        member:ChangeMusic(1, 0)
        member:ChangeMusic(2, 101)
        member:ChangeMusic(3, 102)
        member:setLocalVar("Chart", 0)
    end
end

entity.onMobDeath = function(mob, player)
    local crab = GetMobByID(ID.mob.HEIKE_CRAB)
    local monk = GetMobByID(ID.mob.BEACH_MONK)
    local barnacle = GetNPCByID(ID.npc.BARNACLED_BOX)

    if not crab:isAlive() and not monk:isAlive() then
        barnacle:setLocalVar("leaderID", player:getLeaderID())
        barnacle:teleport(mob:getPos(), mob:getRotPos())
        barnacle:setStatus(xi.status.NORMAL)
        barnacle:setLocalVar("open", 0)
    end

    mob:setLocalVar("twohour", 0)
end

return entity
