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
    
    animatedMob:addListener("SPAWN", "ANIMATED_WEAPON_SPAWN", function(animatedMob)
        animatedMob:SetMagicCastingEnabled(true)
        animatedMob:SetAutoAttackEnabled(true)
        animatedMob:SetMobAbilityEnabled(true)
        animatedMob:setLocalVar("mobName", string.format("%s", xi.dynamis.mobList[animatedMob:getZoneID()][animatedMob:getLocalVar("MobIndex")].info[2]))
        animatedMob:setLocalVar("Text_Index_1", 4)
        animatedMob:setLocalVar("Text_Index_2", 3)
    end)

    animatedMob:addListener("ENGAGE", "ANIMATED_WEAPON_ENGAGE", function(animatedMob, target)
        animatedMob:setLocalVar("changeTime", math.random(20, 30))
        animatedMob:showText(animatedMob, dialogChoice[animatedMob:getLocalVar("mobName")])
    end)

    animatedMob:addListener("COMBAT_TICK", "ANIMATED_WEAPON_CTICK", function(animatedMob) 
        local dialogThresholds = {90, 80, 70, 60, 50, 40, 30, 20, 10}

        for trigger, hpp in pairs(dialogThresholds) do
            if animatedMob:getHPP() < hpp and animatedMob:getLocalVar("dialogTrigger") < trigger then
                animatedMob:setLocalVar("dialogTrigger", trigger)
                animatedMob:setLocalVar("dialogQueue", animatedMob:getLocalVar("dialogQueue") + 1)
                break
            end
        end

        if animatedMob:getLocalVar("dialogQueue") > 0 then
            animatedMob:messageText(animatedMob, dialogChoice[animatedMob:getLocalVar("mobName")] + animatedMob:getLocalVar("Text_Index_1")) -- standard text
            animatedMob:setLocalVar("dialogOne", animatedMob:getLocalVar("Text_Index_1") + 2)
            animatedMob:messageText(animatedMob, dialogChoice[animatedMob:getLocalVar("mobName")] + animatedMob:getLocalVar("Text_Index_2")) -- emote
            animatedMob:setLocalVar("dialogTwo", animatedMob:getLocalVar("Text_Index_2") + 2)
            animatedMob:setLocalVar("dialogQueue", animatedMob:getLocalVar("dialogQueue") - 1)
        end

        if animatedMob:getBattleTime() - animatedMob:getLocalVar("changeTime") >= 0 then
            animatedMob:castSpell(261)
        end
    end)

    animatedMob:addListener("MAGIC_START", "ANIMATED_WEAPON_MAGIC_START", function(animatedMob, spell, action) 
        if spell:getID() == 261 then
            animatedMob:setLocalVar("changeTime", animatedMob:getBattleTime() + math.random(10, 15))
        end
    end)

    animatedMob:addListener("MAGIC_STATE_EXIT", "ANIMATED_WEAPON_MAGIC_STATE_EXIT", function(animatedMob, spell) 
        if spell:getID() == 261 then
            animatedMob:SetMagicCastingEnabled(false)
            animatedMob:SetAutoAttackEnabled(false)
            animatedMob:SetMobAbilityEnabled(false)
            animatedMob:setMobMod(xi.mobMod.NO_MOVE, 1)
        end
    end)

    animatedMob:addListener("DISENGAGE", "ANIMATED_WEAPON_DISENGAGE", function(animatedMob) 
        animatedMob:showText(animatedMob, dialogChoice[animatedMob:getLocalVar("mobName")] + 2)
    end)

    animatedMob:addListener("DEATH", "ANIMATED_WEAPON_DEATH", function(animatedMob, killer) 
        animatedMob:showText(animatedMob, dialogChoice[animatedMob:getLocalVar("mobName")] + 1)
    end)
end

return g_mixins.families.animated_weapons
