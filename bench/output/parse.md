
# Benchmark

Benchmark run from 2022-03-22 21:13:14.610848Z UTC

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
    <td style="white-space: nowrap">15.50 GB</td>
  </tr><tr>
    <th style="white-space: nowrap">Elixir Version</th>
    <td style="white-space: nowrap">1.13.3</td>
  </tr><tr>
    <th style="white-space: nowrap">Erlang Version</th>
    <td style="white-space: nowrap">24.2.1</td>
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
    <td style="white-space: nowrap; text-align: right">269.09</td>
    <td style="white-space: nowrap; text-align: right">3.72 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;10.85%</td>
    <td style="white-space: nowrap; text-align: right">3.76 ms</td>
    <td style="white-space: nowrap; text-align: right">4.93 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap; text-align: right">57.46</td>
    <td style="white-space: nowrap; text-align: right">17.40 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;14.94%</td>
    <td style="white-space: nowrap; text-align: right">15.95 ms</td>
    <td style="white-space: nowrap; text-align: right">22.74 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap; text-align: right">3.64</td>
    <td style="white-space: nowrap; text-align: right">274.42 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;4.30%</td>
    <td style="white-space: nowrap; text-align: right">273.09 ms</td>
    <td style="white-space: nowrap; text-align: right">310.75 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap; text-align: right">2.25</td>
    <td style="white-space: nowrap; text-align: right">445.42 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;4.73%</td>
    <td style="white-space: nowrap; text-align: right">444.97 ms</td>
    <td style="white-space: nowrap; text-align: right">499.95 ms</td>
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
    <td style="white-space: nowrap;text-align: right">269.09</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap; text-align: right">57.46</td>
    <td style="white-space: nowrap; text-align: right">4.68x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap; text-align: right">3.64</td>
    <td style="white-space: nowrap; text-align: right">73.84x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap; text-align: right">2.25</td>
    <td style="white-space: nowrap; text-align: right">119.86x</td>
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
    <td style="white-space: nowrap">2.38 MB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap">17.77 MB</td>
    <td>7.46x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap">275.47 MB</td>
    <td>115.75x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap">320.26 MB</td>
    <td>134.57x</td>
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
    <td style="white-space: nowrap; text-align: right">138.38</td>
    <td style="white-space: nowrap; text-align: right">7.23 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;14.23%</td>
    <td style="white-space: nowrap; text-align: right">7.62 ms</td>
    <td style="white-space: nowrap; text-align: right">10.06 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap; text-align: right">28.75</td>
    <td style="white-space: nowrap; text-align: right">34.78 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;4.58%</td>
    <td style="white-space: nowrap; text-align: right">35.01 ms</td>
    <td style="white-space: nowrap; text-align: right">37.82 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap; text-align: right">3.24</td>
    <td style="white-space: nowrap; text-align: right">308.57 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;6.85%</td>
    <td style="white-space: nowrap; text-align: right">304.48 ms</td>
    <td style="white-space: nowrap; text-align: right">371.05 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap; text-align: right">0.56</td>
    <td style="white-space: nowrap; text-align: right">1786.45 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;2.62%</td>
    <td style="white-space: nowrap; text-align: right">1778.58 ms</td>
    <td style="white-space: nowrap; text-align: right">1865.74 ms</td>
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
    <td style="white-space: nowrap;text-align: right">138.38</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap; text-align: right">28.75</td>
    <td style="white-space: nowrap; text-align: right">4.81x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap; text-align: right">3.24</td>
    <td style="white-space: nowrap; text-align: right">42.7x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap; text-align: right">0.56</td>
    <td style="white-space: nowrap; text-align: right">247.2x</td>
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
    <td style="white-space: nowrap">6.27 MB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap">27.96 MB</td>
    <td>4.46x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap">194.18 MB</td>
    <td>30.98x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap">1585.45 MB</td>
    <td>252.92x</td>
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
    <td style="white-space: nowrap; text-align: right">50.98</td>
    <td style="white-space: nowrap; text-align: right">0.0196 s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;4.83%</td>
    <td style="white-space: nowrap; text-align: right">0.0196 s</td>
    <td style="white-space: nowrap; text-align: right">0.0226 s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap; text-align: right">7.60</td>
    <td style="white-space: nowrap; text-align: right">0.132 s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;2.48%</td>
    <td style="white-space: nowrap; text-align: right">0.132 s</td>
    <td style="white-space: nowrap; text-align: right">0.138 s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap; text-align: right">0.70</td>
    <td style="white-space: nowrap; text-align: right">1.42 s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;10.57%</td>
    <td style="white-space: nowrap; text-align: right">1.44 s</td>
    <td style="white-space: nowrap; text-align: right">1.72 s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap; text-align: right">0.143</td>
    <td style="white-space: nowrap; text-align: right">6.99 s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1.80%</td>
    <td style="white-space: nowrap; text-align: right">6.96 s</td>
    <td style="white-space: nowrap; text-align: right">7.13 s</td>
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
    <td style="white-space: nowrap;text-align: right">50.98</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap; text-align: right">7.60</td>
    <td style="white-space: nowrap; text-align: right">6.71x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap; text-align: right">0.70</td>
    <td style="white-space: nowrap; text-align: right">72.62x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap; text-align: right">0.143</td>
    <td style="white-space: nowrap; text-align: right">356.35x</td>
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
    <td style="white-space: nowrap">15.68 MB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap">111.10 MB</td>
    <td>7.08x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap">950.29 MB</td>
    <td>60.59x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap">6378.19 MB</td>
    <td>406.69x</td>
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
    <td style="white-space: nowrap; text-align: right">648.52</td>
    <td style="white-space: nowrap; text-align: right">1.54 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;13.19%</td>
    <td style="white-space: nowrap; text-align: right">1.53 ms</td>
    <td style="white-space: nowrap; text-align: right">2.21 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap; text-align: right">98.54</td>
    <td style="white-space: nowrap; text-align: right">10.15 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;5.55%</td>
    <td style="white-space: nowrap; text-align: right">10.22 ms</td>
    <td style="white-space: nowrap; text-align: right">11.40 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap; text-align: right">9.01</td>
    <td style="white-space: nowrap; text-align: right">110.96 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;7.74%</td>
    <td style="white-space: nowrap; text-align: right">109.79 ms</td>
    <td style="white-space: nowrap; text-align: right">145.02 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap; text-align: right">2.21</td>
    <td style="white-space: nowrap; text-align: right">453.23 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;4.13%</td>
    <td style="white-space: nowrap; text-align: right">456.99 ms</td>
    <td style="white-space: nowrap; text-align: right">479.67 ms</td>
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
    <td style="white-space: nowrap;text-align: right">648.52</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap; text-align: right">98.54</td>
    <td style="white-space: nowrap; text-align: right">6.58x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap; text-align: right">9.01</td>
    <td style="white-space: nowrap; text-align: right">71.96x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap; text-align: right">2.21</td>
    <td style="white-space: nowrap; text-align: right">293.93x</td>
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
    <td style="white-space: nowrap">1.35 MB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap">9.35 MB</td>
    <td>6.93x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap">86.38 MB</td>
    <td>63.99x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap">572.74 MB</td>
    <td>424.26x</td>
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
    <td style="white-space: nowrap; text-align: right">1104.69</td>
    <td style="white-space: nowrap; text-align: right">0.91 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;16.28%</td>
    <td style="white-space: nowrap; text-align: right">0.88 ms</td>
    <td style="white-space: nowrap; text-align: right">1.39 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap; text-align: right">240.96</td>
    <td style="white-space: nowrap; text-align: right">4.15 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;13.24%</td>
    <td style="white-space: nowrap; text-align: right">3.97 ms</td>
    <td style="white-space: nowrap; text-align: right">5.61 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap; text-align: right">23.71</td>
    <td style="white-space: nowrap; text-align: right">42.17 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;12.92%</td>
    <td style="white-space: nowrap; text-align: right">43.04 ms</td>
    <td style="white-space: nowrap; text-align: right">56.67 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap; text-align: right">5.39</td>
    <td style="white-space: nowrap; text-align: right">185.65 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;9.95%</td>
    <td style="white-space: nowrap; text-align: right">175.10 ms</td>
    <td style="white-space: nowrap; text-align: right">221.57 ms</td>
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
    <td style="white-space: nowrap;text-align: right">1104.69</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap; text-align: right">240.96</td>
    <td style="white-space: nowrap; text-align: right">4.58x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap; text-align: right">23.71</td>
    <td style="white-space: nowrap; text-align: right">46.58x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap; text-align: right">5.39</td>
    <td style="white-space: nowrap; text-align: right">205.08x</td>
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
    <td style="white-space: nowrap">0.81 MB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap">4.31 MB</td>
    <td>5.3x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap">39.09 MB</td>
    <td>48.12x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap">275.88 MB</td>
    <td>339.62x</td>
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
    <td style="white-space: nowrap; text-align: right">25.45</td>
    <td style="white-space: nowrap; text-align: right">0.0393 s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;7.55%</td>
    <td style="white-space: nowrap; text-align: right">0.0397 s</td>
    <td style="white-space: nowrap; text-align: right">0.0489 s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap; text-align: right">6.06</td>
    <td style="white-space: nowrap; text-align: right">0.165 s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;11.74%</td>
    <td style="white-space: nowrap; text-align: right">0.155 s</td>
    <td style="white-space: nowrap; text-align: right">0.21 s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap; text-align: right">0.57</td>
    <td style="white-space: nowrap; text-align: right">1.74 s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;5.48%</td>
    <td style="white-space: nowrap; text-align: right">1.73 s</td>
    <td style="white-space: nowrap; text-align: right">1.93 s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap; text-align: right">0.0792</td>
    <td style="white-space: nowrap; text-align: right">12.62 s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;2.45%</td>
    <td style="white-space: nowrap; text-align: right">12.52 s</td>
    <td style="white-space: nowrap; text-align: right">12.97 s</td>
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
    <td style="white-space: nowrap;text-align: right">25.45</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap; text-align: right">6.06</td>
    <td style="white-space: nowrap; text-align: right">4.2x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap; text-align: right">0.57</td>
    <td style="white-space: nowrap; text-align: right">44.31x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap; text-align: right">0.0792</td>
    <td style="white-space: nowrap; text-align: right">321.13x</td>
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
    <td style="white-space: nowrap">0.0246 GB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">feeder_ex</td>
    <td style="white-space: nowrap">0.137 GB</td>
    <td>5.57x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">elixir_feed_parser</td>
    <td style="white-space: nowrap">1.11 GB</td>
    <td>45.18x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">feed_raptor</td>
    <td style="white-space: nowrap">8.22 GB</td>
    <td>333.76x</td>
  </tr>
</table>


