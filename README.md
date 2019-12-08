# SpaceXToy

## Architecture: MVVM + Datastore

*ViewModel* in this architecture only deals with display related view logic. Data fetching related logic is handled by either remote *Datastore* or local Datastore. 

In this assignment, grouping by name or year is display related logic. However fetching launches or rocket details or sorted results are data related logic, because it might be provided by the backend. After getting sorted results, *ViewModel* then applies grouping on them. 

Data is firstly fetched from remote and then immediately saved to local data store, which is *InMemoryService* in this particular case. *ViewModel* or *Model* doesn’t store data. *Controllers* fetch data from *Datastore* and update *ViewModel* whenever necessary.

*LocalDataStore* can be anything, as well as *RemoteDataStore*. *DataStore* implements *Singleton* pattern.  

## Some assumptions:

1. Assume the data entries I used are always provided the SpaceX API. If a launch misses one of them, I just simply ignore the launch. 
2. Sorted and grouped by mission name by default. Sorting by either mission name or launch date is always in ascending order.
3. I only picked up a few data entries for detail view… I think that should be enough. 
4. Assume network is always good - didn’t put in any progress indicator or network checking.
5. No 3rd party libraries used include RxSwift. 
6. Just use Safari for the URL..
7. No tests implemented
