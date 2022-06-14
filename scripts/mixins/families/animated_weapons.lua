-- Animated Weapons Mixin for Era Dynamis Module
-- Used to perform text choices and determine when to warp.

require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local dialogChoice =
{
    ["Animated Knuckles"] = 7297,
    ["Animated Dagger"] = 7329,
    ["Animated Longsword"] = 7361,
    ["Animated Claymore"] = 7393,
    ["Animated Tabar"] = 7425,
    ["Animated Greataxe"] = 7457,
    ["Animated Spear"] = 7489,
    ["Animated Scythe"] = 7521,
    ["Animated Kunai"] = 7553,
    ["Animated Tachi"] = 7585,
    ["Animated Hammer"] = 7617,
    ["Animated Staff"] = 7649,
    ["Animated Longbow"] = 7681,
    ["Animated Gun"] = 7713,
    ["Animated Horn"] = 7745,
    ["Animated Shield"] = 7777,
}

g_mixins.families.animated_weapons = function(animatedMob)

    animatedMob:addListener("SPAWN", "ANIMATED_WEAPON_SPAWN", function(mob)
        mob:SetMagicCastingEnabled(true)
        mob:SetAutoAttackEnabled(true)
        mob:SetMobAbilityEnabled(true)
        mob:setLocalVar("mobName", string.format("%s", xi.dynamis.mobList[mob:getZoneID()][mob:getLocalVar("MobIndex")].info[2]))
        mob:setLocalVar("Text_Index_1", 4)
        mob:setLocalVar("Text_Index_2", 3)
    end)

    animatedMob:addListener("ENGAGE", "ANIMATED_WEAPON_ENGAGE", function(mob, target)
        mob:setLocalVar("changeTime", math.random(20, 30))
        mob:showText(mob, dialogChoice[mob:getLocalVar("mobName")])
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
            mob:messageText(mob, dialogChoice[mob:getLocalVar("mobName")] + mob:getLocalVar("Text_Index_1")) -- standard text
            mob:setLocalVar("dialogOne", mob:getLocalVar("Text_Index_1") + 2)
            mob:messageText(mob, dialogChoice[mob:getLocalVar("mobName")] + mob:getLocalVar("Text_Index_2")) -- emote
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
        mob:showText(mob, dialogChoice[mob:getLocalVar("mobName")] + 2)
    end)

    animatedMob:addListener("DEATH", "ANIMATED_WEAPON_DEATH", function(mob, killer)
        mob:showText(mob, dialogChoice[mob:getLocalVar("mobName")] + 1)
    end)
end

return g_mixins.families.animated_weapons
