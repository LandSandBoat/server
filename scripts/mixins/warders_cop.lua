-----------------------------------
-- Mixin for Warder NMs in CoP
-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
g_mixins = g_mixins or {}

g_mixins.warders_cop = function(mob)
    mob:addListener('COMBAT_TICK', 'WARDER_CTICK', function(mobArg)
        local battletime = mob:getBattleTime()
        local changeTime = mob:getLocalVar('changeTime')
        local initiate = mob:getLocalVar('initiate')
        local warder = mob:getLocalVar('warder')
        local electro = mob:getLocalVar('electro')
        local reactive = mob:getLocalVar('reactive')
        local ID = zones[mob:getZoneID()]

        if
            battletime - initiate >= 27 and
            warder <= 1
        then -- warder signals to the others before using abilities
            mob:showText(mob, ID.text.BEEP_BEEP)
            mob:setLocalVar('initiate', battletime)
        elseif
            battletime - changeTime >= 30 and
            warder >= 1
        then -- shortly after each will use the same ability at the same time
            mob:showText(mob, ID.text.BEEP_CLICK_WHIR)
            mob:setLocalVar('initiate', battletime)
            mob:setLocalVar('changeTime', battletime)
            if electro == 1 then
                mob:useMobAbility(561) -- use Electromagnetic Field
                mob:setLocalVar('electro', 0)
            elseif reactive == 1 then
                mob:useMobAbility(562) -- use Reactive Armor
                mob:setLocalVar('reactive', 0)
            end
        end
    end)

    mob:addListener('WEAPONSKILL_STATE_ENTER', 'WS_START_MSG', function(mobArg, skillID)
        if skillID == 561 then -- if warders use Electromagnetic Field, use Reactive Armor next
            mob:setLocalVar('reactive', 1)
        elseif skillID == 562 then -- if warders use Reactive Armor, use Electromagnetic Field next
            mob:setLocalVar('electro', 1)
        end
    end)
end

return g_mixins.warders_cop
