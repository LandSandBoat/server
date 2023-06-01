-----------------------------------
-- Area: Misareaux Coast
--   NM: Gration
-----------------------------------
local ID = require("scripts/zones/Misareaux_Coast/IDs")
mixins = { require("scripts/mixins/fomor_hate") }
require("scripts/globals/items")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addListener("ITEM_DROPS", "ITEM_DROPS_GRATION", function(mobArg, loot)
        loot:addItemFixed(xi.items.TATAMI_SHIELD, mob:getLocalVar("DropRate"))
    end)
end

entity.onMobSpawn = function(mob)
    local shield = GetNPCByID(ID.npc.GRATION_QM):getLocalVar("shield")
    if shield == 2 then
        mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    end

    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMod(xi.mod.FASTCAST, 25)
    mob:setLocalVar("fomorHateAdj", 2)
    mob:setMod(xi.mod.MATT, 125)
    mob:setMod(xi.mod.ATT, 550)
end

entity.onMobFight = function(mob, target)
    local enmityList = mob:getEnmityList()
    for _, v in ipairs(enmityList) do
        local shouldintimidate = math.random(1, 20)
        if shouldintimidate >= 19 then
            if v.entity:hasStatusEffect(xi.effect.INTIMIDATE) then
                v.entity:delStatusEffectSilent(xi.effect.INTIMIDATE)
            end

            v.entity:addStatusEffectEx(xi.effect.INTIMIDATE, 0, 1, 0, 1)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    local random = math.random(1, 2) -- Gration only uses Power Attack or Grand Slam
    if random == 1 then
        return 667 -- Power Attack
    else
        return 665 -- Grand Slam
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local shield = GetNPCByID(ID.npc.GRATION_QM):getLocalVar("shield")
    if skill:getID() == 667 then
        local powerattackCounter = mob:getLocalVar("powerattackCounter")

        powerattackCounter = powerattackCounter + 1
        mob:setLocalVar("powerattackCounter", powerattackCounter)

        if powerattackCounter > 1 and shield == 1 then
            mob:setLocalVar("powerattackCounter", 0)
        elseif powerattackCounter > 2 and shield == 2 then
            mob:setLocalVar("powerattackCounter", 0)
        else
            mob:useMobAbility(667)
        end
    end
end

return entity
