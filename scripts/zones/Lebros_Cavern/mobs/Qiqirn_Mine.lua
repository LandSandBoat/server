-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
--  Mob: Qiqirn Mine
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    local instance = mob:getInstance()
    local players = instance:getChars()
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:SetAutoAttackEnabled(false)

    for i, v in pairs(players) do
        v:messageSpecial(ID.text.MINE_COUNTDOWN, 10)
        mob:timer(5000, function(mob) v:messageSpecial(ID.text.MINE_COUNTDOWN, 5) end)
        mob:timer(6000, function(mob) v:messageSpecial(ID.text.MINE_COUNTDOWN, 4) end)
        mob:timer(7000, function(mob) v:messageSpecial(ID.text.MINE_COUNTDOWN, 3) end)
        mob:timer(8000, function(mob) v:messageSpecial(ID.text.MINE_COUNTDOWN, 2) end)
        mob:timer(9000, function(mob) v:messageSpecial(ID.text.MINE_COUNTDOWN, 1) mob:setLocalVar("Time", 1) end)
    end
end

function onMobFight(mob, target)
    if mob:getLocalVar("Time") == 1 then
        mob:useMobAbility(1838)
        mob:setLocalVar("Time", 2)
    elseif mob:getLocalVar("Time") == 2 then
        mob:timer(2000, function(mob) mob:setHP(0) end)
    end
end

function onMobWeaponSkill(target, mob, skill)
    local pos = mob:getPos()
    local instance = mob:getInstance()

    if skill:getID() == 1838 then
        if (pos.x == 178 and pos.y == -40 and pos.z == 376) then
            instance:getEntity(bit.band(ID.mob[21].BRITTLE_ROCK1, 0xFFF), tpz.objType.MOB):setHP(0)
        elseif (pos.x == 258 and pos.y == -30 and pos.z == 213) then
            instance:getEntity(bit.band(ID.mob[21].BRITTLE_ROCK3, 0xFFF), tpz.objType.MOB):setHP(0)
        elseif (pos.x == 303 and pos.y == -30 and pos.z == 341) then
            instance:getEntity(bit.band(ID.mob[21].BRITTLE_ROCK4, 0xFFF), tpz.objType.MOB):setHP(0)
        elseif (pos.x == 338 and pos.y == -30 and pos.z == 296) then
            instance:getEntity(bit.band(ID.mob[21].BRITTLE_ROCK5, 0xFFF), tpz.objType.MOB):setHP(0)
        end
    end
end

function onMobDeath(mob, player, isKiller)
end
