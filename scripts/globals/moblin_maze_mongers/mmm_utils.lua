-----------------------------------
-- Moblin Maze Mongers: Utilities
-----------------------------------
xi = xi or {}
xi.mmm = xi.mmm or {}
-----------------------------------
-- Char Vars used in MMM:
-- '[MMM]Tabula'         -- Set on (successful) Tabula trade. Theory: Used along Voucher for Layout (and objective by extension) and difficulty.
-- '[MMM]Voucher'        -- Set on (successful) Tabula trade. Theory: Used along Voucher for Layout (and objective by extension) and difficulty.
-- '[MMM]Runes'          -- Set on (successful) Tabula trade. Verious effects.
-- '[MMM]exitTime'       -- Set on maze exit. Could be set in "Evergloom Hollow" onZoneOut directly. Used for CC points.
-- '[MMM]CompletedMazes' -- Set on successful maze completion. Tracks how many times you didn't fail.Used for title purchuase.
-----------------------------------

xi.mmm.calculateCCPoints = function(player)
    local ccPoints     = 0
    local mazeExitTime = player:getCharVar('[MMM]exitTime')

    if mazeExitTime > 0 then
        local timeDiff = os.time() - mazeExitTime - 3600 -- Current time - Re-Enter time
        ccPoints       = math.floor(timeDiff / 1200)     -- Recieve 1 point every 20 minutes. (First hour doesnt generate C.C. Points)
        ccPoints       = utils.clamp(ccPoints, 0, 6)     -- No negative points. Max 6.
    end

    return ccPoints
end
