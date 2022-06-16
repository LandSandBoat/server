-- Animated Weapons Mixin for Era Dynamis Module
-- Used to perform text choices and determine when to warp.

require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local dialogChoice =
{
    ["DE_AKnu"] = {7297},
    ["DE_ADag"] = {7329},
    ["DE_ALon"] = {7361},
    ["DE_ACla"] = {7393},
    ["DE_ATab"] = {7425},
    ["DE_AGre"] = {7457},
    ["DE_ASpe"] = {7489},
    ["DE_AScy"] = {7521},
    ["DE_AKun"] = {7553},
    ["DE_ATac"] = {7585},
    ["DE_AHam"] = {7617},
    ["DE_ASta"] = {7649},
    ["DE_Alon"] = {7681},
    ["DE_AGun"] = {7713},
    ["DE_AHor"] = {7745},
    ["DE_AShi"] = {7777},
}

g_mixins.families.animated_weapons = function(animatedMob)

    animatedMob:addListener("SPAWN", "ANIMATED_WEAPON_SPAWN", function(mob)
        mob:SetMagicCastingEnabled(true)
        mob:SetAutoAttackEnabled(true)
        mob:SetMobAbilityEnabled(true)
        print(mob:getLocalVar("MobIndex"))
        mob:setLocalVar("Text", dialogChoice[mob:getName()][1])
        mob:setLocalVar("Text_Index_1", 4)
        mob:setLocalVar("Text_Index_2", 3)
    end)

    animatedMob:addListener("ENGAGE", "ANIMATED_WEAPON_ENGAGE", function(mob, target)
        mob:setLocalVar("changeTime", math.random(20, 30))
        mob:showText(mob, dialogChoice[mob:getName()][1])
    end)

    animatedMob:addListener("COMBAT_TICK", "ANIMATED_WEAPON_CTICK", function(mob)
        local dialogThresholds = {90, 80, 70, 60, 50, 40, 30, 20, 10}

        for trigger, hpp in pairs(dialogThresholds) do
            if mob:getHPP() < hpp and mob:getLocalVar("dialogTrigger") < trigger then
                mob:setLocalVar("dialogTrigger", trigger)
                mob:setLocalVar("dialogQueue", mob:getLocalVar("dialogQueue") + 1)
                break
            end
        end

        if mob:getLocalVar("dialogQueue") > 0 then
            mob:showText(mob, dialogChoice[mob:getName()][1] + mob:getLocalVar("Text_Index_1")) -- standard text
            mob:setLocalVar("dialogOne", mob:getLocalVar("Text_Index_1") + 2)
            mob:showText(mob, dialogChoice[mob:getName()][1] + mob:getLocalVar("Text_Index_2")) -- emote
            mob:setLocalVar("dialogTwo", mob:getLocalVar("Text_Index_2") + 2)
            mob:setLocalVar("dialogQueue", mob:getLocalVar("dialogQueue") - 1)
        end

        if mob:getBattleTime() - mob:getLocalVar("changeTime") >= 0 then
            mob:castSpell(261)
        end
    end)

    animatedMob:addListener("MAGIC_START", "ANIMATED_WEAPON_MAGIC_START", function(mob, spell, action)
        if spell:getID() == 261 then
            mob:setLocalVar("changeTime", mob:getBattleTime() + math.random(10, 15))
        end
    end)

    animatedMob:addListener("MAGIC_STATE_EXIT", "ANIMATED_WEAPON_MAGIC_STATE_EXIT", function(mob, spell)
        if spell:getID() == 261 then
            mob:SetMagicCastingEnabled(false)
            mob:SetAutoAttackEnabled(false)
            mob:SetMobAbilityEnabled(false)
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        end
    end)

    animatedMob:addListener("DISENGAGE", "ANIMATED_WEAPON_DISENGAGE", function(mob)
        mob:showText(mob, dialogChoice[mob:getName()][1] + 2)
    end)

    animatedMob:addListener("DEATH", "ANIMATED_WEAPON_DEATH", function(mob, killer)
        mob:showText(mob, dialogChoice[mob:getName()][1] + 1)
    end)
end

return g_mixins.families.animated_weapons
