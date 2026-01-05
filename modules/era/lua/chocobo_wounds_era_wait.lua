-----------------------------------
-- Chocobo Wounds Era Module
-- 1 Vanad'iel day wait between feeds
-- Safe for startup sanity checks
-----------------------------------
require('modules/module_utils')

-- luacheck: globals Module xi VanadielUniqueDay

local m = Module:new('chocobo_wounds_era_wait')

m:addOverride('xi.server.onServerStart', function(super)
    if super then
        super()
    end

    xi.module.modifyInteractionEntry('scripts/quests/Jeuno/Chocobos_Wounds', function(quest)
        local section = quest.sections[2] and quest.sections[2][xi.zone.UPPER_JEUNO]
        if not section or not section['Chocobo'] then
            return
        end

        local originalOnTrade = section['Chocobo'].onTrade

        section['Chocobo'].onTrade = function(player, npc, trade)
            if not player then
                return 0
            end

            local today = VanadielUniqueDay()
            local lastDay = quest:getVar(player, 'Timer')

            -- Enforce 1 Vana'diel day wait
            if lastDay == today then
                return quest:progressEvent(73)
            end

            if originalOnTrade then
                local result = originalOnTrade(player, npc, trade)

                -- Only set timer if trade succeeded
                if result then
                    quest:setVar(player, 'Timer', today)
                end

                return result or 0
            end

            return 0
        end
    end)
end)

return m
