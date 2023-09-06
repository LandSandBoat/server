-----------------------------------
-- Area: The Ashu Talif (The Black Coffin)
--  Mob: Gessho
-- TOAU-15 Mission Battle
-----------------------------------
local ID = zones[xi.zone.THE_ASHU_TALIF]
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- Gessho will engage by himself ~1min in if you stall too long.
    -- Give a little buffer for while the instance loads
    mob:timer(80000, function(m)
        if m:getLocalVar('ready') == 0 and not m:getTarget() then
            xi.ally.startAssist(m, xi.ally.ASSIST_RANDOM)
        end
    end)

    mob:addListener('WEAPONSKILL_STATE_ENTER', 'WS_START_MSG', function(m, skillID)
        -- Hane Fubuki
        if skillID == 1998 then
            m:showText(m, ID.text.UNNATURAL_CURS)
        -- Hiden Sokyaku
        elseif skillID == 1999 then
            m:showText(m, ID.text.STING_OF_MY_BLADE)
        -- Happobarai
        elseif skillID == 2001 then
            m:showText(m, ID.text.HARNESS_THE_WHIRLWIND)
        -- Rinpyotosha
        elseif skillID == 2002 then
            m:showText(m, ID.text.SWIFT_AS_LIGHTNING)
        end
    end)
end

entity.onMobEngaged = function(mob, target)
    local dialog = mob:getLocalVar('dialog')

    if dialog == 0 then
        mob:showText(mob, ID.text.BATTLE_HIGH_SEAS)
        mob:setLocalVar('dialog', 1)
    end
end

entity.onMobRoam = function(mob)
    local ready = mob:getLocalVar('ready')

    -- When Gessho becomes ready via you pulling, he will assist you
    if ready == 1 then
        xi.ally.startAssist(mob, xi.ally.ASSIST_PLAYER)
    end
end

entity.onMobFight = function(mob, target)
    local dialog = mob:getLocalVar('dialog')

    if mob:getHPP() <= 20 and dialog == 1 then
        mob:showText(mob, ID.text.TIME_IS_NEAR)
        mob:setLocalVar('dialog', 2)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    mob:showText(mob, ID.text.SO_I_FALL)
end

return entity
