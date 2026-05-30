
# Benchmark

Benchmark run from 2026-05-30 18:55:09.899952Z UTC

## System

Benchmark suite executing on the following system:

<table style="width: 1%">
  <tr>
    <th style="width: 1%; white-space: nowrap">Operating System</th>
    <td>Linux</td>
  </tr><tr>
    <th style="white-space: nowrap">CPU Information</th>
    <td style="white-space: nowrap">12th Gen Intel(R) Core(TM) i5-12600K</td>
  </tr><tr>
    <th style="white-space: nowrap">Number of Available Cores</th>
    <td style="white-space: nowrap">16</td>
  </tr><tr>
    <th style="white-space: nowrap">Available Memory</th>
    <td style="white-space: nowrap">15.49 GB</td>
  </tr><tr>
    <th style="white-space: nowrap">Elixir Version</th>
    <td style="white-space: nowrap">1.14.1</td>
  </tr><tr>
    <th style="white-space: nowrap">Erlang Version</th>
    <td style="white-space: nowrap">25.1.2</td>
  </tr>
</table>

## Configuration

Benchmark suite executing with the following configuration:

<table style="width: 1%">
  <tr>
    <th style="width: 1%">:time</th>
    <td style="white-space: nowrap">30 s</td>
  </tr><tr>
    <th>:parallel</th>
    <td style="white-space: nowrap">1</td>
  </tr><tr>
    <th>:warmup</th>
    <td style="white-space: nowrap">5 s</td>
  </tr>
</table>

## Statistics




__Input: anxiety__

Run Time

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Devitation</th>
    <th style="text-align: right">Median</th>
    <th style="text-align: right">99th&nbsp;%</th>
  </tr>

  <tr>
    <td style="white-space: nowrap">gluttony</td>
    <td style="white-space: nowrap; text-align: right">269.36</td>
    <td style="white-space: nowrap; text-align: right">3.71 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;16.80%</td>
    <td style="white-space: nowrap; text-align: right">3.59 ms</td>
    <td style="white-space: nowrap; text-align: right">6.39 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap; text-align: right">62.52</td>
    <td style="white-space: nowrap; text-align: right">16.00 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;12.02%</td>
    <td style="white-space: nowrap; text-align: right">15.57 ms</td>
    <td style="white-space: nowrap; text-align: right">24.49 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap; text-align: right">4.27</td>
    <td style="white-space: nowrap; text-align: right">234.32 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;8.38%</td>
    <td style="white-space: nowrap; text-align: right">228.53 ms</td>
    <td style="white-space: nowrap; text-align: right">358.23 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap; text-align: right">2.73</td>
    <td style="white-space: nowrap; text-align: right">365.71 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;13.08%</td>
    <td style="white-space: nowrap; text-align: right">360.55 ms</td>
    <td style="white-space: nowrap; text-align: right">567.46 ms</td>
  </tr>

</table>


Comparison

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">gluttony</td>
    <td style="white-space: nowrap;text-align: right">269.36</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap; text-align: right">62.52</td>
    <td style="white-space: nowrap; text-align: right">4.31x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap; text-align: right">4.27</td>
    <td style="white-space: nowrap; text-align: right">63.12x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap; text-align: right">2.73</td>
    <td style="white-space: nowrap; text-align: right">98.51x</td>
  </tr>

</table>



Memory Usage

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">Memory</th>
    <th style="text-align: right">Factor</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">gluttony</td>
    <td style="white-space: nowrap">3.10 MB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap">17.70 MB</td>
    <td>5.71x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap">274.75 MB</td>
    <td>88.57x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap">320.15 MB</td>
    <td>103.2x</td>
  </tr>
</table>



__Input: ben__

Run Time

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Devitation</th>
    <th style="text-align: right">Median</th>
    <th style="text-align: right">99th&nbsp;%</th>
  </tr>

  <tr>
    <td style="white-space: nowrap">gluttony</td>
    <td style="white-space: nowrap; text-align: right">122.67</td>
    <td style="white-space: nowrap; text-align: right">8.15 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;16.71%</td>
    <td style="white-space: nowrap; text-align: right">7.83 ms</td>
    <td style="white-space: nowrap; text-align: right">14.85 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap; text-align: right">37.81</td>
    <td style="white-space: nowrap; text-align: right">26.45 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;6.74%</td>
    <td style="white-space: nowrap; text-align: right">26.22 ms</td>
    <td style="white-space: nowrap; text-align: right">32.28 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap; text-align: right">4.15</td>
    <td style="white-space: nowrap; text-align: right">240.73 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;8.54%</td>
    <td style="white-space: nowrap; text-align: right">236.12 ms</td>
    <td style="white-space: nowrap; text-align: right">331.17 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap; text-align: right">0.69</td>
    <td style="white-space: nowrap; text-align: right">1452.95 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;5.13%</td>
    <td style="white-space: nowrap; text-align: right">1442.22 ms</td>
    <td style="white-space: nowrap; text-align: right">1713.01 ms</td>
  </tr>

</table>


Comparison

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">gluttony</td>
    <td style="white-space: nowrap;text-align: right">122.67</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap; text-align: right">37.81</td>
    <td style="white-space: nowrap; text-align: right">3.24x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap; text-align: right">4.15</td>
    <td style="white-space: nowrap; text-align: right">29.53x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap; text-align: right">0.69</td>
    <td style="white-space: nowrap; text-align: right">178.24x</td>
  </tr>

</table>



Memory Usage

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">Memory</th>
    <th style="text-align: right">Factor</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">gluttony</td>
    <td style="white-space: nowrap">8.14 MB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap">27.94 MB</td>
    <td>3.43x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap">193.86 MB</td>
    <td>23.81x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap">1580.19 MB</td>
    <td>194.05x</td>
  </tr>
</table>



__Input: daily__

Run Time

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Devitation</th>
    <th style="text-align: right">Median</th>
    <th style="text-align: right">99th&nbsp;%</th>
  </tr>

  <tr>
    <td style="white-space: nowrap">gluttony</td>
    <td style="white-space: nowrap; text-align: right">38.15</td>
    <td style="white-space: nowrap; text-align: right">0.0262 s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;13.42%</td>
    <td style="white-space: nowrap; text-align: right">0.0253 s</td>
    <td style="white-space: nowrap; text-align: right">0.0420 s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap; text-align: right">9.45</td>
    <td style="white-space: nowrap; text-align: right">0.106 s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;12.23%</td>
    <td style="white-space: nowrap; text-align: right">0.102 s</td>
    <td style="white-space: nowrap; text-align: right">0.161 s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap; text-align: right">0.75</td>
    <td style="white-space: nowrap; text-align: right">1.33 s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;4.98%</td>
    <td style="white-space: nowrap; text-align: right">1.34 s</td>
    <td style="white-space: nowrap; text-align: right">1.49 s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap; text-align: right">0.161</td>
    <td style="white-space: nowrap; text-align: right">6.22 s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;8.66%</td>
    <td style="white-space: nowrap; text-align: right">6.51 s</td>
    <td style="white-space: nowrap; text-align: right">6.72 s</td>
  </tr>

</table>


Comparison

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">gluttony</td>
    <td style="white-space: nowrap;text-align: right">38.15</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap; text-align: right">9.45</td>
    <td style="white-space: nowrap; text-align: right">4.04x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap; text-align: right">0.75</td>
    <td style="white-space: nowrap; text-align: right">50.89x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap; text-align: right">0.161</td>
    <td style="white-space: nowrap; text-align: right">237.12x</td>
  </tr>

</table>



Memory Usage

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">Memory</th>
    <th style="text-align: right">Factor</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">gluttony</td>
    <td style="white-space: nowrap">21.26 MB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap">111.11 MB</td>
    <td>5.23x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap">949.61 MB</td>
    <td>44.66x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap">6366.98 MB</td>
    <td>299.43x</td>
  </tr>
</table>



__Input: dave__

Run Time

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Devitation</th>
    <th style="text-align: right">Median</th>
    <th style="text-align: right">99th&nbsp;%</th>
  </tr>

  <tr>
    <td style="white-space: nowrap">gluttony</td>
    <td style="white-space: nowrap; text-align: right">492.66</td>
    <td style="white-space: nowrap; text-align: right">2.03 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;20.11%</td>
    <td style="white-space: nowrap; text-align: right">1.97 ms</td>
    <td style="white-space: nowrap; text-align: right">3.60 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap; text-align: right">122.15</td>
    <td style="white-space: nowrap; text-align: right">8.19 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;12.78%</td>
    <td style="white-space: nowrap; text-align: right">8.05 ms</td>
    <td style="white-space: nowrap; text-align: right">12.80 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap; text-align: right">11.51</td>
    <td style="white-space: nowrap; text-align: right">86.89 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;9.62%</td>
    <td style="white-space: nowrap; text-align: right">86.08 ms</td>
    <td style="white-space: nowrap; text-align: right">117.18 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap; text-align: right">2.36</td>
    <td style="white-space: nowrap; text-align: right">423.43 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;7.92%</td>
    <td style="white-space: nowrap; text-align: right">411.91 ms</td>
    <td style="white-space: nowrap; text-align: right">532.73 ms</td>
  </tr>

</table>


Comparison

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">gluttony</td>
    <td style="white-space: nowrap;text-align: right">492.66</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap; text-align: right">122.15</td>
    <td style="white-space: nowrap; text-align: right">4.03x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap; text-align: right">11.51</td>
    <td style="white-space: nowrap; text-align: right">42.81x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap; text-align: right">2.36</td>
    <td style="white-space: nowrap; text-align: right">208.61x</td>
  </tr>

</table>



Memory Usage

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">Memory</th>
    <th style="text-align: right">Factor</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">gluttony</td>
    <td style="white-space: nowrap">1.92 MB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap">9.31 MB</td>
    <td>4.86x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap">86.29 MB</td>
    <td>45.05x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap">571.72 MB</td>
    <td>298.5x</td>
  </tr>
</table>



__Input: sleepy__

Run Time

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Devitation</th>
    <th style="text-align: right">Median</th>
    <th style="text-align: right">99th&nbsp;%</th>
  </tr>

  <tr>
    <td style="white-space: nowrap">gluttony</td>
    <td style="white-space: nowrap; text-align: right">807.19</td>
    <td style="white-space: nowrap; text-align: right">1.24 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;27.82%</td>
    <td style="white-space: nowrap; text-align: right">1.18 ms</td>
    <td style="white-space: nowrap; text-align: right">2.51 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap; text-align: right">259.91</td>
    <td style="white-space: nowrap; text-align: right">3.85 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;15.28%</td>
    <td style="white-space: nowrap; text-align: right">3.80 ms</td>
    <td style="white-space: nowrap; text-align: right">5.83 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap; text-align: right">31.25</td>
    <td style="white-space: nowrap; text-align: right">32.00 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;17.93%</td>
    <td style="white-space: nowrap; text-align: right">30.86 ms</td>
    <td style="white-space: nowrap; text-align: right">48.70 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap; text-align: right">5.08</td>
    <td style="white-space: nowrap; text-align: right">196.96 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;8.52%</td>
    <td style="white-space: nowrap; text-align: right">191.79 ms</td>
    <td style="white-space: nowrap; text-align: right">252.39 ms</td>
  </tr>

</table>


Comparison

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">gluttony</td>
    <td style="white-space: nowrap;text-align: right">807.19</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap; text-align: right">259.91</td>
    <td style="white-space: nowrap; text-align: right">3.11x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap; text-align: right">31.25</td>
    <td style="white-space: nowrap; text-align: right">25.83x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap; text-align: right">5.08</td>
    <td style="white-space: nowrap; text-align: right">158.98x</td>
  </tr>

</table>



Memory Usage

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">Memory</th>
    <th style="text-align: right">Factor</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">gluttony</td>
    <td style="white-space: nowrap">1.11 MB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap">4.27 MB</td>
    <td>3.86x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap">39.01 MB</td>
    <td>35.28x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap">275.17 MB</td>
    <td>248.84x</td>
  </tr>
</table>



__Input: stuff__

Run Time

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Devitation</th>
    <th style="text-align: right">Median</th>
    <th style="text-align: right">99th&nbsp;%</th>
  </tr>

  <tr>
    <td style="white-space: nowrap">gluttony</td>
    <td style="white-space: nowrap; text-align: right">21.20</td>
    <td style="white-space: nowrap; text-align: right">0.0472 s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;12.65%</td>
    <td style="white-space: nowrap; text-align: right">0.0455 s</td>
    <td style="white-space: nowrap; text-align: right">0.0725 s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap; text-align: right">6.73</td>
    <td style="white-space: nowrap; text-align: right">0.149 s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;9.57%</td>
    <td style="white-space: nowrap; text-align: right">0.145 s</td>
    <td style="white-space: nowrap; text-align: right">0.24 s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap; text-align: right">0.59</td>
    <td style="white-space: nowrap; text-align: right">1.69 s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;9.32%</td>
    <td style="white-space: nowrap; text-align: right">1.67 s</td>
    <td style="white-space: nowrap; text-align: right">1.96 s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap; text-align: right">0.102</td>
    <td style="white-space: nowrap; text-align: right">9.80 s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;3.18%</td>
    <td style="white-space: nowrap; text-align: right">9.75 s</td>
    <td style="white-space: nowrap; text-align: right">10.22 s</td>
  </tr>

</table>


Comparison

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">gluttony</td>
    <td style="white-space: nowrap;text-align: right">21.20</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap; text-align: right">6.73</td>
    <td style="white-space: nowrap; text-align: right">3.15x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap; text-align: right">0.59</td>
    <td style="white-space: nowrap; text-align: right">35.77x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap; text-align: right">0.102</td>
    <td style="white-space: nowrap; text-align: right">207.84x</td>
  </tr>

</table>



Memory Usage

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">Memory</th>
    <th style="text-align: right">Factor</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">gluttony</td>
    <td style="white-space: nowrap">0.0366 GB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap">0.137 GB</td>
    <td>3.75x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap">1.11 GB</td>
    <td>30.37x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap">8.20 GB</td>
    <td>224.06x</td>
  </tr>
</table>


