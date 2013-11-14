scribe Cookbook
===============
This cookbook install scribe and start scribe server 

Requirements
------------

Attributes
----------

#### scribe::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['scribe']['remote_host']</tt></td>
    <td>String</td>
    <td>remote host to send logs</td>
    <td><tt>None</tt></td>
  </tr>
</table>

Usage
-----
#### scribe::default
Just include `scribe` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[scribe]"
  ]
  "scribe": {
    "remote_host": "your.remote.hostname"
  }
}
```

License and Authors
-------------------
Authors: Lee Ho Sung (hslee@enswer.net)
