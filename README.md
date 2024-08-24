basically have it so now we have a datframe thats easy to select on year, city, and region

run sab.R to run code. All the other files are just functions that are called by that

see video called sab.mov

To get the graph to shuw up I'm highlighting all the code in sab.R and then pressing command+enter

Notes
- Noticed a bit of an anomaly The white population of **suburbs** of **San Francisco, CA** for **year** **1990** is **1,826,959** but the **total population** is **723,959**

```
suburb %>% filter(full_name == 'San Francisco, CA' & year == 1990)
```

- if you look at the **census** population of **San Francisco, CA** for year **1990** the **total population** is also **723,959**

```
census %>% filter(full_name == 'San Francisco, CA' & year == 1990)
```

- this makes me think that the **total_pop** column for the suburb dataset is incorrect
- this is also true for **Tucson, AZ**, **Atlanta, GA**, and **Boston, MA**
