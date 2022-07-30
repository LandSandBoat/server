-----------------------------------
-- Area: Lufaise Meadows
--   NM: Kurrea
-----------------------------------
local ID = require("scripts/zones/Lufaise_Meadows/IDs")
-----------------------------------
local entity = {}

local buffs = -- Buff, potency, messageID
{
    {                    "Cure",  25,    ID.text.KURREA_CURE},
    {           xi.effect.HASTE,  25, ID.text.KURREA_MUSCLES},
    { xi.effect.PHYSICAL_SHIELD,   1,    ID.text.KURREA_AURA},
    { xi.effect.MAGIC_ATK_BOOST, 100,    ID.text.KURREA_EYES},
    {   xi.effect.DEFENSE_BOOST, 100,   ID.text.KURREA_RIGID},
    {    xi.effect.ATTACK_BOOST, 100,    ID.text.KURREA_VEIN},
    {    xi.effect.MAGIC_SHIELD,   1,   ID.text.KURREA_SHINE},
    {   xi.effect.EVASION_BOOST, 100,    ID.text.KURREA_WIND},
    {    xi.effect.DEFENSE_DOWN, 100,   ID.text.KURREA_GREEN},
}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("[CastTime]ID_208", 1)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setLocalVar("moving", 0)
    mob:setLocalVar("runAway", os.time() + math.random(20, 30))
    mob:setMod(xi.mod.REGEN, 50)
end

entity.onMobFight = function(mob, target)
    -- Every 20-30 seconds, Kurrea runs back to his spawn point and gains a random buff
    local runAway = mob:getLocalVar("runAway")
    local spawn = mob:getSpawnPos()
    local moving = mob:getLocalVar("moving")

    if os.time() > runAway and moving == 0 then
        mob:SetMagicCastingEnabled(false)
        mob:SetMobAbilityEnabled(false)
        mob:setLocalVar("moving", 1)
        mob:pathTo(spawn.x, spawn.y, spawn.z)
    elseif os.time() > runAway and moving == 1 and
    (math.floor(mob:getXPos()) > -247 and math.floor(mob:getXPos()) < -244) and
    (math.floor(mob:getZPos()) > 39 and math.floor(mob:getZPos()) < 43) then
        mob:setSpeed(0)
        mob:setLocalVar("twohour_tp", mob:getTP())
        mob:useMobAbility(624) -- 2hr dust cloud
        mob:messageText(target, ID.text.KURREA_SLURPS, false)
        mob:setLocalVar("moving", 2)
        mob:timer(4000, function(mobArg)
            mobArg:setLocalVar("moving", 0)
            mobArg:setSpeed(40)
            mobArg:SetMagicCastingEnabled(true)
            mobArg:SetMobAbilityEnabled(true)
            mobArg:setLocalVar("runAway", os.time() + math.random(20, 30))
            local chooseBuff = math.random(1, 9)
            for k,v in pairs(buffs) do
                if chooseBuff == 1 and k == 1 then
                    mobArg:messageText(target, v[3], false)
                    mobArg:addHP(mobArg:getMaxHP() * .25)
                    break
                elseif chooseBuff == k then
                    mobArg:messageText(target, v[3], false)
                    mobArg:addStatusEffectEx(v[1], 0, v[2], 0, 20)
                    break
                end
            end
        end)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 603 then -- blue: High ATK, double and triple attack. High magic immunity
        mob:addTP(mob:getLocalVar("twohour_tp"))
        mob:setLocalVar("twohour_tp", 0)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
