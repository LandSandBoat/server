-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Time Bomb
-- BCNM: 3, 2, 1...
-- TODO: Players should not be expelled from the battlefield
-- if the bomb self-destructs.
-----------------------------------
local ID = require("scripts/zones/Waughroon_Shrine/IDs")
-----------------------------------

local entity = {}

local timeTable =
{
    { 59, ID.text.BOMB_TIMER_1,  8 },
    { 58, ID.text.BOMB_TIMER_2,  7 },
    { 57, ID.text.BOMB_TIMER_3,  6 },
    { 56, ID.text.BOMB_TIMER_4,  5 },
    { 55, ID.text.BOMB_TIMER_5,  4 },
    { 50, ID.text.BOMB_TIMER_10, 3 },
    { 40, ID.text.BOMB_TIMER_20, 2 },
    { 30, ID.text.BOMB_TIMER_30, 1 },
}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
end

entity.onMobEngaged = function(mob, target)
    mob:setLocalVar("selfDestruct", os.time() + 60)
    mob:setLocalVar("warning", 8)
    mob:messageText(target, ID.text.BOMB_TIMER_60, false)
    mob:setAutoAttackEnabled(false)
    mob:setMobAbilityEnabled(false)
end

entity.onMobFight = function(mob, target)
    local warning = mob:getLocalVar("warning")

    for k, v in pairs(timeTable) do
        if warning >= k and mob:getBattleTime() == v[1] then
            mob:messageText(target, v[2], false)
            mob:setLocalVar("warning", warning - 1)
        end
    end

    if
        os.time() > mob:getLocalVar("selfDestruct") and
        mob:getBattlefield():getLocalVar("control") == 0
    then
        mob:getBattlefield():setLocalVar("control", 1)
        mob:useMobAbility(256)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if player:getBattlefield():getLocalVar("control") == 0 then
        player:getBattlefield():setLocalVar("lootSpawned", 0)
    end
end

return entity
