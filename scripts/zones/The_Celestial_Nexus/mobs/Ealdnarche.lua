-----------------------------------
-- Area: The Celestial Nexus
--  Mob: Eald'narche (Phase 1)
-- Zilart Mission 16 BCNM Fight
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onMobInitialize(mob)
    --50% fast cast, no standback
    mob:addMod(tpz.mod.UFASTCAST, 50)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
end

function onMobSpawn(mob)
    mob:SetAutoAttackEnabled(false)
    mob:setMobMod(tpz.mobMod.GA_CHANCE, 25)
    mob:addStatusEffectEx(tpz.effect.PHYSICAL_SHIELD, 0, 1, 0, 0)
    mob:addStatusEffectEx(tpz.effect.ARROW_SHIELD, 0, 1, 0, 0)
    mob:addStatusEffectEx(tpz.effect.MAGIC_SHIELD, 0, 1, 0, 0)
end

function onMobEngaged(mob, target)
    mob:addStatusEffectEx(tpz.effect.SILENCE, 0, 1, 0, 5)
    GetMobByID(mob:getID() + 1):updateEnmity(target)
end

function onMobFight(mob, target)
    if (mob:getBattleTime() % 9 <= 2) then
        local orbitalOne = GetMobByID(mob:getID()+3)
        local orbitalTwo = GetMobByID(mob:getID()+4)

        if not orbitalOne:isSpawned() then
            orbitalOne:setPos(mob:getPos())
            orbitalOne:spawn()
            orbitalOne:updateEnmity(target)
        elseif not orbitalTwo:isSpawned() then
            orbitalTwo:setPos(mob:getPos())
            orbitalTwo:spawn()
            orbitalTwo:updateEnmity(target)
        end
    end
end

function onMobDeath(mob, player, isKiller)
    DespawnMob(mob:getID()+1)
    DespawnMob(mob:getID()+3)
    DespawnMob(mob:getID()+4)
    local battlefield = player:getBattlefield()
    player:startEvent(32004, battlefield:getArea())
end

function onEventUpdate(player, csid, option)
    -- printf("updateCSID: %u", csid)
end

function onEventFinish(player, csid, option, target)
    -- printf("finishCSID: %u", csid)
    if (csid == 32004) then
        DespawnMob(target:getID())
        mob = SpawnMob(target:getID()+2)
        mob:updateEnmity(player)
        --the "30 seconds of rest" you get before he attacks you, and making sure he teleports first in range
        mob:addStatusEffectEx(tpz.effect.BIND, 0, 1, 0, 30)
        mob:addStatusEffectEx(tpz.effect.SILENCE, 0, 1, 0, 40)
    end
end
