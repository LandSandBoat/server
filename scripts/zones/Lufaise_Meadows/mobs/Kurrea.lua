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
    { xi.effect.MAGIC_ATK_BOOST, 250,    ID.text.KURREA_EYES},
    {   xi.effect.DEFENSE_BOOST, 250,   ID.text.KURREA_RIGID},
    {    xi.effect.ATTACK_BOOST,   1,    ID.text.KURREA_VEIN},
    {    xi.effect.MAGIC_SHIELD,   1,   ID.text.KURREA_SHINE},
    {   xi.effect.EVASION_BOOST, 250,    ID.text.KURREA_WIND},
    {    xi.effect.DEFENSE_DOWN, 250,   ID.text.KURREA_GREEN},
}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("runAway", os.time() + math.random(20, 30))
    mob:setMod(xi.mod.REGEN, 50)
end

entity.onMobFight = function(mob, target)
    -- Every 20-30 seconds, Kurrea runs back to his spawn point and gains a random buff
    local runAway = mob:getLocalVar("runAway")
    local spawn = mob:getSpawnPos()
    if os.time() > runAway and (mob:getXPos() ~= spawn[1] or mob:getZPos() ~= spawn[3]) then
        mob:SetMagicCastingEnabled(false)
        mob:SetMobAbilityEnabled(false)
        mob:pathTo(spawn[1], spawn[2], spawn[3])
    elseif os.time() > runAway and mob:getXPos() == spawn[1] and mob:getZPos() == spawn[3] then
        mob:messageText(target, ID.text.KURREA_SLURPS, false)
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        mob:setLocalVar("waitTime", os.time() + 3)
        if os.time() > mob:getLocalVar("waitTime") then
            mob:setLocalVar("runAway", os.time() + math.random(20, 30))
            mob:setLocalVar("twohour_tp", mob:getTP())
            mob:useMobAbility(603) -- 2hr dust cloud
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
            mob:SetMagicCastingEnabled(true)
            mob:SetMobAbilityEnabled(true)
            local chooseBuff = math.random(1, 9)
            for k,v in pairs(buffs) do
                if chooseBuff == 1 and k == 1 then
                    mob:messageText(target, v[3], false)
                    mob:addHP(mob:getMaxHP() * .25)
                    break
                elseif chooseBuff == k then
                    mob:messageText(target, v[3], false)
                    mob:addStatusEffectEx(v[1], 0, v[2], 0, 20)
                end
            end
        end
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
