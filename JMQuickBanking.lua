
---
--- JMQuickBanking
---

--[[

    Variable declaration

 ]]

---
-- @field name
-- @field savedVariablesName
--
local Config = {
    name = 'JMQuickBanking',
    savedVariablesName = 'JMQuickBankingSavedVariables',
}

local SavedVariables = {}

--[[

    Initialize

 ]]

---
-- Start of the addon
--
local function Initialize()
    -- Load the saved variables
    SavedVariables = ZO_SavedVars:NewAccountWide(Config.savedVariablesName, 1, nil, {
        --buyList = {},
    })
    --BuyList = SavedVariables.buyList


end


--[[

    Api

 ]]

---
-- Making some functions public
--
JMQuickBanking = {
    -- No API calls yet
}

--[[

    Events

 ]]

--- Adding the initialize handler
EVENT_MANAGER:RegisterForEvent(
    Config.name,
    EVENT_ADD_ON_LOADED,
    function (event, addonName)
        if addonName ~= Config.name then
            return
        end

        Initialize()
        EVENT_MANAGER:UnregisterForEvent(Config.name, EVENT_ADD_ON_LOADED)
    end
)
