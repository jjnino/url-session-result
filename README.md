# url-session-result
A simple generic wrapper around URLSession data task using the Result type and Codable.

It allows for a cleaner api by returning the expected decoded Codable object or an error. For example, fetching a user might look like:

```
URLSession.shared.dataTask(with: URL(string: "https://reqres.in/api/users/2")!) { (result: Result<UserData, Error>) in
    switch result {
    case .success(let userData):
        print(userData.data.first_name)
    case .failure(let error):
        print(error)
    }
}.resume()
```


Check out the playground to give it a try!
Want to use it? Just copy the URLSession extension into your project!
