https://discord.gg/4wpWdm3Pn3

https://yaldabotit-scripts.tebex.io/


To make the qb-core HasItem function compatible with ox_inventory:
Go to qb-core/client/functions.lua
And change :

```
function QBCore.Functions.HasItem(items, amount)
    return exports['qb-inventory']:HasItem(items, amount)
end
```
To this:

```
function QBCore.Functions.HasItem(items, amount)
    amount = amount or 1
    local count = exports.ox_inventory:Search('count', items)
    if type(items) == 'table' and type(count) == 'table' then
        for _, v in pairs(count) do
            if v < amount then
                return false
            end
        end
        return true
    end
    return count >= amount
end
```
